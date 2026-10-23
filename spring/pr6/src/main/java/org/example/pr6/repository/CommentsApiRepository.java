package org.example.pr6.repository;

import org.example.pr6.model.CommentsModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentsRepository extends JpaRepository<CommentsModel, Integer> {
}