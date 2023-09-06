/*
 *  Copyright 2023 Stephen Tetley
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

mod WF.AI2ToS4.Characteristics.PODE {

    // S4Equipment(equiId = String, name = String, objType = String, classType = String, floc = String, status = String)

    pub def podetu(): #{ValuaEquiString(String, String, String), 
                            S4Equipment(String, String, String, String, String, String),
                            EquiMapping(String, String),
                            AibStringValue(String, String, String)} = #{

        ValuaEquiString(equiId, "LOCATION_ON_SITE", value) :- 
            S4Equipment(equiId, _, "PODE", "PODETU", _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("Location On Site", plinum, value).

    }

    

}
