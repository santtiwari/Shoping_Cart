package com.ecom.Repositry;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ecom.Model.UserDtls;

public interface UserRepository extends JpaRepository<UserDtls, Integer> {

	public UserDtls findByEmail(String email);

	public List<UserDtls> findByRole(String role);
	
	public UserDtls findByResetToken(String token);
}
