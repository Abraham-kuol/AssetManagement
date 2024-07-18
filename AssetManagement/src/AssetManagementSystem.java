import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;

public class AssetManagementSystem extends JFrame {
    private JTextField searchField;
    private JTextArea resultArea;
    private Connection connection;

    public AssetManagementSystem() {
        setTitle("Asset Management System");
        setSize(900, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        // Create the main panel with padding
        JPanel mainPanel = new JPanel(new BorderLayout());
        mainPanel.setBorder(new EmptyBorder(10, 10, 10, 10));

        // Create the search panel with a flow layout
        JPanel searchPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        searchPanel.setBorder(BorderFactory.createTitledBorder("Search Assets"));

        searchField = new JTextField(30);
        JButton searchButton = new JButton("Search");
        JButton clearButton = new JButton("Clear");

        searchButton.addActionListener(new SearchListener());
        clearButton.addActionListener(new ClearListener());

        searchPanel.add(new JLabel("Search:"));
        searchPanel.add(searchField);
        searchPanel.add(searchButton);
        searchPanel.add(clearButton);

        // Create the result area with a scroll pane
        resultArea = new JTextArea();
        resultArea.setEditable(false);
        resultArea.setFont(new Font("Monospaced", Font.PLAIN, 12));
        JScrollPane scrollPane = new JScrollPane(resultArea);
        scrollPane.setBorder(BorderFactory.createTitledBorder("Search Results"));

        mainPanel.add(searchPanel, BorderLayout.NORTH);
        mainPanel.add(scrollPane, BorderLayout.CENTER);

        add(mainPanel);

        // Establish database connection
        try {
            // Load the JDBC driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Replace with your actual database connection details
            connection = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=AssetManagement;user=Kuol;password=@SQL@kuol;encrypt=true;trustServerCertificate=true;");
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC Driver not found");
            e.printStackTrace();
        } catch (SQLException e) {
            // Handling any SQL exceptions that might occur
            e.printStackTrace();
        }
    }

    private class SearchListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Get the search term from the user input
            String searchTerm = searchField.getText();
            searchAssets(searchTerm);
        }
    }

    private class ClearListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Clear the search field and results area
            searchField.setText("");
            resultArea.setText("");
        }
    }

    private void searchAssets(String searchTerm) {
        try {
            // Prepare the SQL query with placeholders for search criteria
            String query = "SELECT a.AssetID, a.AssetType, a.Coordinates, a.LocationDetails, a.EstimatedValue, a.OwnershipFees, a.FinancingTracking, a.InsurancePremiums, " +
                    "a.Make, a.Model, a.Year, a.LicensePlate, o.Name as OwnerName " +
                    "FROM Assets a " +
                    "LEFT JOIN AssetOwners ao ON a.AssetID = ao.AssetID " +
                    "LEFT JOIN Owners o ON ao.OwnerID = o.OwnerID " +
                    "WHERE a.AssetType LIKE ? OR a.LocationDetails LIKE ? OR o.Name LIKE ? OR a.Make LIKE ? OR a.Model LIKE ? OR a.LicensePlate LIKE ?";
            PreparedStatement statement = connection.prepareStatement(query);
            // Using wildcards to enable partial matches
            statement.setString(1, "%" + searchTerm + "%");
            statement.setString(2, "%" + searchTerm + "%");
            statement.setString(3, "%" + searchTerm + "%");
            statement.setString(4, "%" + searchTerm + "%");
            statement.setString(5, "%" + searchTerm + "%");
            statement.setString(6, "%" + searchTerm + "%");

            // Execute the query and process the result set
            ResultSet resultSet = statement.executeQuery();
            resultArea.setText("");  // Clear previous results

            while (resultSet.next()) {
                // Append each asset's details to the result area
                resultArea.append("Asset ID: " + resultSet.getInt("AssetID") + "\n");
                resultArea.append("Asset Type: " + resultSet.getString("AssetType") + "\n");
                resultArea.append("Coordinates: " + resultSet.getString("Coordinates") + "\n");
                resultArea.append("Location Details: " + resultSet.getString("LocationDetails") + "\n");
                resultArea.append("Estimated Value: " + resultSet.getBigDecimal("EstimatedValue") + "\n");
                resultArea.append("Ownership Fees: " + resultSet.getBigDecimal("OwnershipFees") + "\n");
                resultArea.append("Financing Tracking: " + resultSet.getString("FinancingTracking") + "\n");
                resultArea.append("Insurance Premiums: " + resultSet.getBigDecimal("InsurancePremiums") + "\n");
                resultArea.append("Make: " + resultSet.getString("Make") + "\n");
                resultArea.append("Model: " + resultSet.getString("Model") + "\n");
                resultArea.append("Year: " + resultSet.getInt("Year") + "\n");
                resultArea.append("License Plate: " + resultSet.getString("LicensePlate") + "\n");
                resultArea.append("Owner: " + resultSet.getString("OwnerName") + "\n\n");
            }
        } catch (SQLException e) {
            // Handle SQL exceptions
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        // Ensure the GUI runs on the Event Dispatch Thread
        SwingUtilities.invokeLater(() -> {
            AssetManagementSystem frame = new AssetManagementSystem();
            frame.setVisible(true);  // Make the frame visible
        });
    }
}
