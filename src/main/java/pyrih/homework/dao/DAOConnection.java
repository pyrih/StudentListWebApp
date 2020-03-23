package pyrih.homework.dao;

import pyrih.homework.entity.Student;

import java.util.List;

public interface DAOConnection {
    void connect();

    void disconnect();

    List<Student> selectAllStudents();

    Student getStudent(int id);

    boolean createStudent(String name, float scholarShip);

    void updateStudent(int id, float sum);

    void deleteStudent(int id);
}
