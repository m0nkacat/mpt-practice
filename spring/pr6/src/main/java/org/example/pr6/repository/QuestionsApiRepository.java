package org.example.pr6.repository;

import org.example.pr6.model.QuestionsModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionsRepository extends JpaRepository<QuestionsModel, Integer> {
}