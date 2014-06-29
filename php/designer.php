class designer extend employee {
    protected $type=null
    protected function setType($type){
        $this->type = $type;
        return $this->type;
    }
    protected function getType(){
        return $this->type;
    }
}
