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

mod WF.AI2ToS4.Rules2 {

    // Equipment(equiId = Int32, name = String, Floc = String, status = String)

    pub def easting(): #{IntValuaEqui(Int32, String, Int32), 
                            Equipment(Int32, String, String, String),
                            EquiMapping(String, Int32), 
                            AiParent(String, String),
                            AiGridRef(String, String)} = #{
        IntValuaEqui(equiId, "EASTING", WF.Base.Osgb36.eastingfromOsgb36(gridref)) :- 
            Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AiParent(plinum, sainum),
            AiGridRef(sainum, gridref).
    }

    pub def northing(): #{IntValuaEqui(Int32, String, Int32), 
                            Equipment(Int32, String, String, String),
                            EquiMapping(String, Int32), 
                            AiParent(String, String),
                            AiGridRef(String, String)} = #{
        IntValuaEqui(equiId, "Northing", WF.Base.Osgb36.northingfromOsgb36(gridref)) :- 
            Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AiParent(plinum, sainum),
            AiGridRef(sainum, gridref).
    }

}
