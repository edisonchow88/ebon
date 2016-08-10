<?php
/*------------------------------------------------------------------------------
  $Id$

  AbanteCart, Ideal OpenSource Ecommerce Solution
  http://www.AbanteCart.com

  Copyright © 2011-2015 Belavier Commerce LLC

  This source file is subject to Open Software License (OSL 3.0)
  License details is bundled with this package in the file LICENSE.txt.
  It is also available at this URL:
  <http://www.opensource.org/licenses/OSL-3.0>

 UPGRADE NOTE:
   Do not edit or add to this file if you wish to upgrade AbanteCart to newer
   versions in the future. If you wish to customize AbanteCart for your
   needs please refer to http://www.AbanteCart.com for more information.
------------------------------------------------------------------------------*/
if (!defined('DIR_CORE')) {
	header('Location: static_pages/');
}
/**
 * Class AAdmin
 */
final class AAdmin {
    /**
     * @var int
     */
    private $admin_id;
    /**
     * @var string
     */
    private $email;
    private $username;
    private $last_login;
    /**
     * @var array
     */
    private $permission = array();

	/**
	 * @param $registry Registry
	 */
	public function __construct($registry) {
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');

		if (isset($this->session->data['admin_id'])) {
			$admin_query = $this->db->query("SELECT * FROM " . $this->db->table("admin") . " WHERE admin_id = '" . (int)$this->session->data['admin_id'] . "'");

			if ($admin_query->num_rows) {
				$this->admin_id = $admin_query->row['admin_id'];
				$this->email = $admin_query->row['email'];
				$this->username = $admin_query->row['username'];
				$this->last_login = $this->session->data['admin_last_login'];
				$this->role_id = (int)$admin_query->row['role_id'];

				$this->db->query("UPDATE " . $this->db->table("admin") . " 
      			                  SET ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'
      			                  WHERE admin_id = '" . (int)$this->session->data['admin_id'] . "'");

                $admin_group_query = $this->db->query("SELECT permission
      			                                      FROM " . $this->db->table("admin_role") . " 
      			                                      WHERE role_id = '" . (int)$admin_query->row['role_id'] . "'");
				if (unserialize($admin_group_query->row['permission'])) {
					foreach (unserialize($admin_group_query->row['permission']) as $key => $value) {
						$this->permission[$key] = $value;
					}
				}
			} else {
				$this->logout();
			}
		} else {
			unset($this->session->data['token']);
		}
	}

    /**
     * @param $username string
     * @param $password string
     * @return bool
     */
    public function login($username, $password) {
		$admin_query = $this->db->query("SELECT *
    	                                FROM " . $this->db->table("admin") . " 
    	                                WHERE username = '" . $this->db->escape($username) . "'
    	                                AND password = '" . $this->db->escape(AEncryption::getHash($password)) . "'");

		if ($admin_query->num_rows) {
			$this->session->data['admin_id'] = $admin_query->row['admin_id'];
			$this->session->data['admin_last_login'] = $admin_query->row['last_login'];

			$this->admin_id = $admin_query->row['admin_id'];
			$this->username = $admin_query->row['username'];
			$this->last_login = $admin_query->row['last_login'];
			if (!$this->last_login || $this->last_login == 'null' || $this->last_login == '0000-00-00 00:00:00') {
				$this->session->data['admin_last_login'] = $this->last_login = '';
			}

			$this->db->query("UPDATE " . $this->db->table("admin") . " 
							  SET last_login = NOW()
							  WHERE admin_id = '" . (int)$this->session->data['admin_id'] . "'");

			$admin_group_query = $this->db->query("SELECT permission
      		                                      FROM " . $this->db->table("admin_role") . " 
      		                                      WHERE role_id = '" . (int)$admin_query->row['role_id'] . "'");

			if ($admin_group_query->row['permission']) {
				foreach (unserialize($admin_group_query->row['permission']) as $key => $value) {
					$this->permission[$key] = $value;
				}
			}
			return TRUE;
		} else {
			return FALSE;
		}
	}

	public function logout() {
		unset($this->session->data['admin_id']);

		$this->admin_id = '';
		$this->username = '';
	}

    /**
     * @param $key - route to controller
     * @param $value bool
     * @return bool
     */
    public function hasPermission($key, $value) {
		//If top_admin allow all permisson. Make sure Top Admin Group is set to ID 1
		if ($this->role_id == 1) {
			return TRUE;
		} else if (isset($this->permission[$key])) {
			return $this->permission[$key][$value] == 1 ? true : false;
		} else {
			return FALSE;
		}
	}

    /**
     * @param string $value  - route to controller
     * @return bool
     */
    public function canAccess($value) {
		return $this->hasPermission('access', $value);
	}

    /**
     * @param string $value route to controller
     * @return bool
     */
    public function canModify($value) {
		return $this->hasPermission('modify', $value);
	}

    /**
     * @param string $token
     * @return bool|int
     */
    public function isLoggedWithToken( $token ) {
		if ( (isset($this->session->data['token']) && !isset( $token ))
			|| ( (isset( $token ) && (isset($this->session->data['token']) && ( $token != $this->session->data['token'])))) ) {
			return FALSE;
		} else {
			return $this->admin_id;
		}
	}

    /**
     * @return bool|int
     */
    public function isLogged() {
		if (IS_ADMIN && $this->request->get['token'] != $this->session->data['token']) {
			return false;
		}
		return $this->admin_id;
	}

    /**
     * @return int
     */
    public function getId() {
		return $this->admin_id;
	}

    /**
     * @return string
     */
    public function getUserName() {
		return $this->username;
	}

    /**
     * @return string
     */
    public function getLastLogin() {
		return $this->last_login;
	}

    /**
     * @param string $username
     * @param string $email
     * @return bool
     */
    public function validate($username, $email) {
		$admin_query = $this->db->query(
			"SELECT * FROM " . $this->db->user.php . " 
			WHERE username = '" . $this->db->escape($username) . "'
				AND email = '" . $this->db->escape($email) . "'");

		if ($admin_query->num_rows)
			return true;
		else
			return false;
	}

    /**
     * @param int $length
     * @return string
     */
    static function generatePassword($length = 8) {
		$chars = "1234567890abcdefghijkmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		$i = 0;
		$password = "";
		while ($i <= $length) {
			$password .= $chars{mt_rand(0, strlen($chars))};
			$i++;
		}
		return $password;
	}

	/**
	 * @return string
	 */
	public function getAvatar() {
		return getGravatar($this->email);
	}
	
}
