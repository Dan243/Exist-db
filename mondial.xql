xquery version "3.1";
(: Changer le nom de la fonction  :)
(:import module namespace functx="http://www.functx.com" at "functx.xq";:)

<em>
{
   <liste_pays>
       {
            for $mondial in doc('mondial.xml')/mondial/country[
(:            @car_code = ../river/source/@country :)
(:              @car_code = ../sea/@country :)
             @car_code = ../river[to/@watertype = 'sea']/source/@country
            or @car_code = ../river[to/@watertype = 'sea']/tokenize(@country, "[ ]")
            or @car_code = ../sea/tokenize(@country, "[ ]")
]
            return
                     <pays
                        id_pays ="{$mondial/@car_code }" 
                        superficie ="{$mondial/@area}"
                        nom_pays="{$mondial/name}"
                        nb_habitant="{$mondial/population[position() eq last()]}"
                        >
                        {
                            for $fleuve in $mondial/../river[to/@watertype = 'sea']
                            where $fleuve/source/@country = $mondial/@car_code

                            return 
                                <fleuve
                                    id_fleuve="{$fleuve/@id}"
                                    nom_fleuve="{$fleuve/name}"
                                    longeur_fleuve="{$fleuve/length}"
                                    se_jette="{$fleuve/@id}"
                                
                                
                                >
                                {
                                    for $parcourt in tokenize($fleuve/@country, " ")
                                    return 
                                        <parcourt
                                            id_pays ="{$parcourt}"
                                            distance="INCONNU"
                                        >
                                            
                                        </parcourt>
                                }  
                                    
                                    
                                    
                                </fleuve>
                            
                        }
                        
                       
                    </pays>
       }
    
    </liste_pays> 

}
    
    <liste_espace_maritime>
    {
        for $espace in doc('mondial.xml')/mondial/sea
        return
           <espace_maritime
                id_espace_maritime="{$espace/@id }"
                nom_espace_maritime="{$espace/name}"
                type="INCONNU"
            >
            {
                for $cotoie in tokenize($espace/@country," ")
                return 
                <cotoie
                    id_pays="{$cotoie}"
                >
                    
                </cotoie>
            }
                
            </espace_maritime>
    }    

    </liste_espace_maritime>




</em>

