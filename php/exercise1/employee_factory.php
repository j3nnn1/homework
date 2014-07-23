require_once('programmer.php');
require_once('designer.php');

class EmployeeFactory {

function __construct(){
	$this->programmer = new Programmer();     
	$this->designer = new Designer();     
}
function solver($type){
    switch($type){
        case 'programmer':
            return $this->programmer;
        break;
        case 'designer':
            return $this->designer;
        break;
        default:
            return $this->designer;
        break;
    }
}
}

