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




mod WF.Difference.Diff1 {

    use WF.Difference.Diff
    use WF.Difference.Diff.{Add, Del, Diff, Same}

    // Diffing betwen two s4 records - one is expected to have a dollar Id (?)

    // S4Equipment(equiId = String, name = String, objType = String, classType = String, floc = String, status = String)


    pub def diffValuaEqui(): #{DiffValuaEquiString(String, String, String, Diff[String]),
                                DiffValuaEquiInt(String, String, String, Diff[Int32]),
                                S4Equipment(String, String, String, String, String, String),
                                Matches(String, String),
                                ValuaEquiString(String, String, String),
                                ValuaEquiInt(String, String, Int32)} = #{

        DiffValuaEquiString(equiId, otherId, charName, if (value != otherValue) Diff(value, otherValue) else Same(value)) :- 
            S4Equipment(equiId, _, _, _, _, _),
            ValuaEquiString(equiId, charName, value), 
            Matches(equiId, otherId),
            ValuaEquiString(otherId, charName, otherValue).
        
        DiffValuaEquiInt(equiId, otherId, charName, if (value != otherValue) Diff(value, otherValue) else Same(value)) :- 
            S4Equipment(equiId, _, _, _, _, _),
            ValuaEquiInt(equiId, charName, value), 
            Matches(equiId, otherId),
            ValuaEquiInt(otherId, charName, otherValue), 
            if value != otherValue.

    } 


}
