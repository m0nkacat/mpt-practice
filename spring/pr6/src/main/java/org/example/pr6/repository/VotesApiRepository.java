package org.example.pr6.repository;

import org.example.pr6.model.VotesModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VotesRepository extends JpaRepository<VotesModel, Integer> {
}