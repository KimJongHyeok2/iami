package com.web.iami.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

@Component
@SuppressWarnings("serial")
public class CustomUserDetails implements UserDetails {

	private int mem_no;
	private String mem_id;
	private String mem_pw;
	private String mem_auth;
	private String mem_nickname;
	private String mem_profile;
	private int mem_type;
	private boolean enabled;

	public int getMem_no() {
		return mem_no;
	}

	public String getMem_id() {
		return mem_id;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public String getMem_auth() {
		return mem_auth;
	}

	public String getMem_nickname() {
		return mem_nickname;
	}

	public String getMem_profile() {
		return mem_profile;
	}

	public int getMem_type() {
		return mem_type;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
		roles.add(new SimpleGrantedAuthority(this.mem_auth));
		return roles;
	}

	@Override
	public String getPassword() {
		return this.mem_pw;
	}

	@Override
	public String getUsername() {
		return this.mem_id;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return this.enabled;
	}

}