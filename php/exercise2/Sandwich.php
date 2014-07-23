<?php 
abstract class Ingredients {
    function __construct($name = null) {
        $this->name = $name; 
    }
    public $name = null;
    public $weigth = null;
    abstract function getName(); 
    abstract function setName($name);
    public function getWeigth() {
       return $this->weigth; 
    }
    public function setWeigth($grams) {
       $this->weigth = $grams;
       return $this->weigth;
    }

}

class Cheese extends Ingredients {

    function __construct() {
        echo 'adding ingredient Cheese'."\n";
        $this->setWeigth(10);
        parent::__construct();
    }
    public function getName() {
        return $this->name;
    }
    public function setName($name) {
        $this->name = $name;
        return $this->name;
    }

}
class RawHam extends Ingredients {

    function __construct() {
        echo 'adding ingredient RawHam'. "\n";
        $this->setWeigth(40);
        parent::__construct();
    }
    public function getName() {
        return $this->name;
    }
    public function setName($name) {
        $this->name = $name;
        return $this->name;
    }
}
class Butter extends Ingredients {
    function __construct() {
        echo 'adding ingredient Butter'."\n";
        $this->setWeigth(5);
        parent::__construct();
    }
    public function getName() {
        return $this->name;
    }
    public function setName($name) {
        $this->name = $name;
        return $this->name;
    }
}

class Bread {
    function __construct() { 
	echo 'Bread Base'."\n";
    }
}
class Miga extends Bread {
    function __construct() {
	echo 'Miga Bread Selected'."\n";
    }
}
class Baguette extends Bread {
    function __construct() {
	echo 'Baguette Bread Selected'."\n";
    }
}

interface Eatable {
    function bite($grams);
}

class Sandwich implements Eatable {
    protected $breadType = null; 
    protected $ingredients  = array();
    protected $weigth  = null;

    public function __construct($ingredients = null, $breadType = null) {
        echo 'Create a Basic Sandwich'."\n";
        if (empty($ingredients)) { $this->ingredients = array(); }
        else { $this->ingredients = $ingredients; }

        if (empty($breadType)) { $this->breadType = new Miga(); }
        else {$this->breadType = new $breadType(); }
        $this->weigth = 100;
    }
    public function getWeigth() {
        return $this->weigth;
    }
    public function setWeigth($weigth) {
        $this->weigth = $weigth; 
        return $this->weigth;
    }
    public function addIngredient($ingredient) {
        $i = new $ingredient();
        $this->ingredients[] = $i;
        $this->addWeigth($i->getWeigth());
        return $i;	
    }
    public function addWeigth($weigth) {
        return $this->setWeigth($this->weigth + $weigth);
    } 
    public function getIngredients() {
        return $this->ingredients;
    }
    public function getBreadType() {
        return $this->breadType;
    }
    public function getDescription() {
        $ningre = $this->countIngredients();
        $this->doMessageBreadType();
        $this->doMessageSize();
        echo 'Numero de Ingredientes del Sandwich:'. $ningre ."\n";
        if ($ningre>0) { $this->listIngredients(); }
    }
    public function doMessageSize() {
       echo 'Peso: '.$this->getWeigth()."\n";
    }
   private function doMessageBreadType() { 
        echo 'Tipo de Sandwich:'. get_class($this->getBreadType()) ."\n";
   }
   public function countIngredients() {
        return count($this->getIngredients());
   }
   public function listIngredients() {
        echo 'Ingredientes:'."\n";
        foreach ($this->getIngredients() as $ingredient) {
            echo get_class($ingredient)."\n";
        }
   }
   public function bite($grams) {
       $bite = $this->weigth - $grams;
       if ($bite>0) {
           $this->setWeigth($bite);
       } else {
           $this->setWeigth(0);
       }
       return $grams;
   }
}

$snd = new Sandwich($ingredients = null, $breadType='Miga');
echo 'Sandwich Basico'."\n";
$snd->getDescription();
$snd->addIngredient('Butter');
$snd->addIngredient('Cheese');
$snd->addIngredient('RawHam');
echo 'Sandwich Con Tres Ingredientes'."\n";
$snd->getDescription();

echo 'Luego de una mordida de 30 gr'."\n";
$snd->bite(30);
$snd->getDescription();

echo 'Luego de una mordida de 50 gr'."\n";
$snd->bite(50);
$snd->getDescription();

