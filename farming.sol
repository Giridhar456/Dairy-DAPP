pragma solidity^ 0.4.25;
contract dairyindustry{
    struct product{
        string pname;
        string place;
        uint  price;
        uint  quantity;
        uint shipmentid;
        uint producerid;
        uint processorid;
        uint packagerid;
        uint distributorid;
        uint inhandof;
        bool productcondition;
    }
    mapping(uint => product)products;
        struct producer {
        uint producerid; 
        string name;
        string place;
    }
   mapping (uint => producer)producers;
   struct processor {
       uint processorid;
       string place;
       string name;
       uint chilling;
       uint pasteurization;
    
    
    }
    mapping (uint => processor)processors;
    struct packager {
        uint packagerid;
        string mname;
        string mplace;
        uint mdate;
        uint[] Products;
    }
    mapping (uint => packager)packagers;
    struct distributor {
        uint distributorid;
        string dname;
        string dplace;
        uint[] products;
        

    }
    mapping (uint => distributor)distributors;

    
    event Event(uint shipmentid,uint itemid);
    
    
    modifier Cantbeproducer(uint _processorid,uint _shipmentid) {
        require(products[_shipmentid].producerid != _processorid);
        _;
        
    }
    modifier cantbeprocessor(uint _packagerid,uint _shipmentid){
        require(products[_shipmentid].processorid != _packagerid);
        _;
    }
    modifier cantbepackager(uint _distributorid,uint _shipmentid){
        require(products[_shipmentid].packagerid != _distributorid);
        _;
    }

    
    function insertdetails( string memory _name,string memory _place,uint _price,uint _shipmentid,uint _producerid,uint _quantity)public{
        products[_shipmentid].pname = _name;
        products[_shipmentid].place =_place;
        products[_shipmentid].quantity = _quantity;
        products[_shipmentid].price = _price;
        products[_shipmentid].producerid = _producerid;
        
       emit Event(_shipmentid,_producerid);
    }
    
    function producertoprocessor(uint _shipmentid,uint _processorid,bool _productcondition)public Cantbeproducer(_processorid,_shipmentid){
        products[_shipmentid].processorid = _processorid;
        products[_shipmentid].inhandof = _processorid;
        products[_shipmentid].productcondition = _productcondition;
        
      emit Event(_shipmentid,_processorid);    
    }
    
    function processortopackager(uint _shipmentid,uint _packagerid,bool _productcondition)public cantbeprocessor(_packagerid,_shipmentid){
        products[_shipmentid].packagerid = _packagerid;
        products[_shipmentid].inhandof = _packagerid;
        products[_shipmentid].productcondition = _productcondition;
        packagers[_packagerid].Products.push(_shipmentid);
        
       emit Event(_shipmentid,_packagerid);
    }
    function numberofproductsbypackager(uint _packagerid)public view returns(uint[] memory){
        return (packagers[_packagerid].Products);
    }
    function numberofproductsbydistributor(uint _distributorid)public view returns(uint[] memory){
        return (distributors[_distributorid].products);
    }
    
    
    function packagertodistributor(uint _shipmentid,uint _distributorid,bool _productcondition)public cantbepackager(_distributorid,_shipmentid){
        products[_shipmentid].distributorid = _distributorid;
        products[_shipmentid].inhandof = _distributorid;
        products[_shipmentid].productcondition = _productcondition;
        distributors[_distributorid].products.push(_shipmentid);
        
       emit Event(_shipmentid,_distributorid);
    }
    
        
    function producerdetails(uint _producerid,string memory _name,string memory _place)public{
        producers[_producerid].producerid = _producerid;
        producers[_producerid].name = _name;
        producers[_producerid].place =_place;
           
    }
    function Processor(uint _processorid,string memory _name,string memory _place)public{
        processors[_processorid].processorid = _processorid;
        processors[_processorid].name = _name;
        processors[_processorid].place = _place;
    }
    function Packager(uint _packagerid,string memory _name,string memory _place)public{
        
        packagers[_packagerid].packagerid = _packagerid;
        packagers[_packagerid].mname = _name;
        packagers[_packagerid].mplace = _place;
        
    }
    function Distributor(uint _distributorid,string memory _name,string memory _place)public {
        distributors[_distributorid].distributorid = _distributorid;
        distributors[_distributorid].dname = _name;
        distributors[_distributorid].dplace = _place;
    }
    
    function getsupplychain(uint _shipmentid) view public returns(string memory,string memory,uint,uint,uint,uint){
     return (products[_shipmentid].pname,products[_shipmentid].place,products[_shipmentid].packagerid,products[_shipmentid].producerid,products[_shipmentid].processorid,products[_shipmentid].distributorid);
    }
     function getproductcondition(uint _shipmentid) view public returns(bool){
        return products[_shipmentid].productcondition;
    }
     function getinhandoof(uint _shipmentid) view public returns(uint){
             return products[_shipmentid].inhandof;
          }
          
    function getproducerdetails (uint _producerid)view public returns(uint,string memory,string memory){
       return ( producers[_producerid].producerid,producers[_producerid].name,producers[_producerid].place);
           }
           function getprocessordetails (uint _processorid) view public returns(uint,string memory,string memory){
       return (processors[_processorid].processorid,processors[_processorid].name,processors[_processorid].place);
               
           }
            function getpackagerdetails (uint _packagerid) view public returns(uint,string memory,string memory){
       return ( packagers[_packagerid].packagerid,packagers[_packagerid].mname,packagers[_packagerid].mplace);
               
           }
    function getdistributordetails (uint _distributorid) view public returns(uint,string memory,string memory){
           return ( distributors[_distributorid].distributorid,distributors[_distributorid].dname,distributors[_distributorid].dplace);
           
         }
    
}
