class programmer extend employee {
    protected $language=null;

    function __construct() {
        parent::construct();
    }
    public function setLanguage($language){
	$this->language = $language;
        return $this->language;
    }
    public function getlanguage(){
        return $this->language; 
    }
   
}
