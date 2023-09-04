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

mod WF.AI2ToS4.MasterData {

    // S4Equipment(equiId = Int32, name = String, Floc = String, status = String)

    pub def manuf(): #{StringValuaEqui(Int32, String, String), 
                            S4Equipment(Int32, String, String, String),
                            EquiMapping(String, Int32),
                            AibStringValue(String, String, String)
                            } = #{

        StringValuaEqui(equiId, "Manufacturer", aibvalue) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(plinum, "Manufacturer", aibvalue).

        StringValuaEqui(equiId, "Model Number", aibvalue) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(plinum, "Model", aibvalue).

        StringValuaEqui(equiId, "Serial Number", aibvalue) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(plinum, "Serial Number", aibvalue).


    }

    pub def userStatus(): #{StringValuaEqui(Int32, String, String), 
                            S4Equipment(Int32, String, String, String),
                            EquiMapping(String, Int32),
                            AibStringValue(String, String, String), 
                            UserStatus(String, String)} = #{
        StringValuaEqui(equiId, "User status", s4Status) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(plinum, "AssetStatus", aibvalue),
            UserStatus(aibvalue, s4Status).

        UserStatus("DECOMMISSIONED",        "DCOM").
        UserStatus("DISPOSED OF",           "DISP").
        UserStatus("NON OPERATIONAL",       "NOP").
        UserStatus("OPERATIONAL",           "OPER").
        UserStatus("TO BE CONSTRUCTED",     "UCON").

    }

    // Start-up date - todo use flix-time...

    pub def dateInfo(): #{IntValuaEqui(Int32, String, Int32),
                            DateValuaEqui(Int32, String, Time.LocalDate), 
                            S4Equipment(Int32, String, String, String),
                            EquiMapping(String, Int32),
                            AibDateTimeValue(String, String, Time.LocalDateTime)} = #{
        
        DateValuaEqui(equiId, "Start-up date", Time.LocalDateTime.toLocalDate(value)) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibDateTimeValue(plinum, "Installed From", value).
        
        IntValuaEqui(equiId, "Construction_year", Time.LocalDateTime.getYear(value)) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibDateTimeValue(plinum, "Installed From", value).

        IntValuaEqui(equiId, "Construction_month", Time.LocalDateTime.getMonth(value) |> Time.Month.getValue) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibDateTimeValue(plinum, "Installed From", value).


    }        
}
