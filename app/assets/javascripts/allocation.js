document.addEventListener('turbolinks:load', function() {
  var departmentSelect = document.getElementById('department-select');
  var employeeSelect = document.getElementById('employee-select');

  departmentSelect.addEventListener('change', getEmployee);

  function getEmployee() {
    var selectedDepartmentId = departmentSelect.value;
    fetch('/employees/filter_by_department?department_id=' + selectedDepartmentId)
      .then(response => response.json())
      .then(data => {
        employeeSelect.innerHTML = '';
        data.forEach(function(employee) {
          var option = document.createElement('option');
          option.value = employee.id;
          option.text = employee.f_name;
          employeeSelect.appendChild(option);
        });
      });
  }
});
