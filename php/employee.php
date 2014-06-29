abstract class Employee {
    protected  $id = null;
    protected  $name = null;
    protected  $lastName = null;
    protected  $age = null;

    function __construct() {
        $this->id = time();
    }
    protected function setName($name) {
	$this->name = $name;
	return $this->name;
    }
    
    protected function setLastName($LastName) {
	$this->name = $name;
	return $this->lastName;
    }

    protected function setAge($age) {
        $this->age = $age;
        return $this->age;
    }
    protected function getName() {
	return $this->name;
    }
    
    protected function getLastName() {
	return $this->lastName;
    }

    protected function getAge() {
        return $this->age;
    }

}

