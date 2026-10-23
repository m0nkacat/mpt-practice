package org.example.pr6.repository;

import org.example.pr6.model.RolesModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RolesRepository extends JpaRepository<RolesModel, Integer> {
}