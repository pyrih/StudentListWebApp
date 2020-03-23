package pyrih.homework.dao;

import oracle.jdbc.driver.OracleDriver;
import pyrih.homework.entity.Student;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

public class OracleDAOConnection implements DAOConnection {

    private static OracleDAOConnection oracleDAOConnection;

    private Connection connection;
    private Statement statement;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;
    private Driver driver;

    private OracleDAOConnection() {
        super();
    }

    public static OracleDAOConnection getInstance() {
        if (oracleDAOConnection != null) {
            return oracleDAOConnection;
        } else {
            oracleDAOConnection = new OracleDAOConnection();
            return oracleDAOConnection;
        }
    }


    @Override
    public void connect() {
/*        driver = new OracleDriver();
        try {
            DriverManager.registerDriver(driver);
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "APYRIH", "4130");
            if (!connection.isClosed()) {
                System.out.println("Connected successful!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }*/

        try {
            Hashtable ht = new Hashtable();
            ht.put(Context.INITIAL_CONTEXT_FACTORY,
                    "weblogic.jndi.WLInitialContextFactory");
            ht.put(Context.PROVIDER_URL, "t3://localhost:7001");
            Context ctx = new InitialContext(ht);
            //DataSource ds = (DataSource) ctx.lookup("TaskTrackerDataSource");
            DataSource ds = (DataSource) ctx.lookup("JNDIStudentsDB");
            connection = ds.getConnection();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

    @Override
    public void disconnect() {
        try {
            resultSet.close();
            statement.close();
            connection.close();
            System.out.println("Connection was closed");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //---------READ-------------
    @Override
    public List<Student> selectAllStudents() {
        List<Student> studentList = new ArrayList<>();
        connect();
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery("SELECT * FROM STUDENTS ORDER BY STUDENT_NAME ASC");
            while (resultSet.next()) {
                studentList.add(parseStudent(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        disconnect();
        return studentList;
    }

    //---------SelectById-------------
    @Override
    public Student getStudent(int id) {
        Student student = null;
        connect();
        try {
            preparedStatement = connection.prepareStatement("SELECT * FROM STUDENTS WHERE STUDENT_ID = ?");
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String name = resultSet.getString("STUDENT_NAME");
                float scholarship = resultSet.getFloat("STUDENT_SCHOLARSHIP");
                student = new Student(id, name, scholarship);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        disconnect();
        return student;
    }

    //---------Create-------------
    @Override
    public boolean createStudent(String name, float scholarShip) {
        boolean rowInserted = false;
        connect();
        try {
            statement = connection.prepareStatement("INSERT INTO STUDENTS (STUDENT_ID, STUDENT_NAME, STUDENT_SCHOLARSHIP)" +
                    "VALUES (NULL, ?, ?)");
            ((PreparedStatement) statement).setString(1, name);
            ((PreparedStatement) statement).setFloat(2, scholarShip);
            rowInserted = ((PreparedStatement) statement).executeUpdate() > 0; //
        } catch (SQLException e) {
            e.printStackTrace();
        }
        disconnect();
        return rowInserted;
    }

    //---------Update-------------
    @Override
    public void updateStudent(int id, float sum) {
        connect();
        try {
            statement = connection.prepareStatement("UPDATE STUDENTS SET STUDENT_SCHOLARSHIP = ? WHERE STUDENT_ID = ?");
            ((PreparedStatement) statement).setFloat(1, sum);
            ((PreparedStatement) statement).setInt(2, id);
            ((PreparedStatement) statement).execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        disconnect();
    }

    //---------Delete-------------
    @Override
    public void deleteStudent(int id) {
        connect();
        try {
            statement = connection.prepareStatement("DELETE FROM STUDENTS WHERE STUDENT_ID = ?");
            ((PreparedStatement) statement).setInt(1, id);
            ((PreparedStatement) statement).execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        disconnect();
    }


    private Student parseStudent(ResultSet resultSet) {
        Student student = null;
        try {
            //if (resultSet.next()) {
            int id = resultSet.getInt("STUDENT_ID");
            String name = resultSet.getString("STUDENT_NAME");
            float scholarship = resultSet.getFloat("STUDENT_SCHOLARSHIP");
            student = new Student(id, name, scholarship);
            // }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return student;
    }

}
