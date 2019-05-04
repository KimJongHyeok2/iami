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

	private String mem_id;
	private String mem_pw;
	private String mem_auth;
	private String mem_nickname;
	private boolean enabled;

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
