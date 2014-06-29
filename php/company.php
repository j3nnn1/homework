
<?php 
requiere_once('employee_factory.php');

class company { 

    protected $employees = array(); 

    public function addEmployee($type) {
        $employeeSolver = new EmployeeFactory(); 
        $employee = $employeeSolver->solver($type); 
        $employees[] = $employee;
	return $employee;
    }

    public function listEmployees() {
        foreach ($this->employees as $employee) {
            echo 'Empleado: '. $employee->getName()."\n";
        }
    }

    public function averageEmployees() {
        $sum = 0;
        $count = 0;
        foreach ($this->employees as $employee) {
             $count++;
             $sum = $sum + $employee->getAge();
        }
        return ($sum/$count); 
    }

    public function getEmployeeById($id) {
     
        foreach ($this->employees as $employee) {
             $idTmp = $employee->getId();
             if ($idTmp==$id) {
                 $employeeById = $employee;
                 break;
	     }
        }
        return $employeeById;
    }
}
?>
