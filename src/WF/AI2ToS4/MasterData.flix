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
    
    use WF.Base.DataSource
    use WF.Base.DataSource.{MasterData}

    // S4Equipment(equiId = String, name = String, objType = String, classType = String, floc = String, status = String)

    pub def masterData(): #{AttrString(String, DataSource, String, String), 
                            AttrInt(String, DataSource, String, Int32),
                            AttrDate(String, DataSource, String, Time.LocalDate), 
                            S4Equipment(String, String, String, String, String, String),
                            EquiMapping(String, String),
                            AibStringValue(String, String, String),
                            AibDateTimeValue(String, String, Time.LocalDateTime), 
                            UserStatus(String, String)
                            } = #{

        AttrString(equiId, MasterData, "HERST", aibvalue) :- 
            S4Equipment(equiId, _, _, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(plinum, "Manufacturer", aibvalue).

        AttrString(equiId, MasterData, "TYPBZ", aibvalue) :- 
            S4Equipment(equiId, _, _, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(plinum, "Model Name", aibvalue).

        AttrString(equiId, MasterData, "MAPA_EEQZ", aibvalue) :- 
            S4Equipment(equiId, _, _, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(plinum, "Specific Model/Frame", aibvalue).

        AttrString(equiId, MasterData, "SERGE", aibvalue) :- 
            S4Equipment(equiId, _, _, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(plinum, "Serial No", aibvalue).


        AttrString(equiId, MasterData, "TIDN_EEQZ", aibvalue) :- 
            S4Equipment(equiId, _, _, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(plinum, "P AND I Tag No", aibvalue).
    
        AttrString(equiId, MasterData, "USTA_EQUI", s4Status) :- 
            S4Equipment(equiId, _, _, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(plinum, "Asset Status", aibvalue),
            UserStatus(aibvalue, s4Status).

        AttrString(equiId, MasterData, "USTW_EQUI", s4Status) :- 
            S4Equipment(equiId, _, _, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(plinum, "Asset Status", aibvalue),
            UserStatus(aibvalue, s4Status).

        UserStatus("DECOMMISSIONED",        "DCOM").
        UserStatus("DISPOSED OF",           "DISP").
        UserStatus("NON OPERATIONAL",       "NOP").
        UserStatus("OPERATIONAL",           "OPER").
        UserStatus("TO BE CONSTRUCTED",     "UCON").

        /// Startup Date
        AttrDate(equiId, MasterData, "INBT", Time.LocalDateTime.toLocalDate(value)) :- 
            S4Equipment(equiId, _, _, _, _, _),
            EquiMapping(plinum, equiId),
            AibDateTimeValue(plinum, "Installed From Date", value).
        
        AttrInt(equiId, MasterData, "BAUJJ", Time.LocalDateTime.getYear(value)) :- 
            S4Equipment(equiId, _, _, _, _, _),
            EquiMapping(plinum, equiId),
            AibDateTimeValue(plinum, "Installed From Date", value).

        AttrInt(equiId, MasterData, "BAUMM_EQI", Time.LocalDateTime.getMonth(value) |> Time.Month.getValue) :- 
            S4Equipment(equiId, _, _, _, _, _),
            EquiMapping(plinum, equiId),
            AibDateTimeValue(plinum, "Installed From Date", value).

    }        

}
