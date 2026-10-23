package org.example.pr6.repository;

import org.example.pr6.model.AnswersModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AnswersRepository extends JpaRepository<AnswersModel, Integer> {
}