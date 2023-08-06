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

    // Equipment(equiId = Int32, name = String, Floc = String, status = String)


    pub def userStatus(): #{IntValuaEqui(Int32, String, Int32), 
                            Equipment(Int32, String, String, String),
                            EquiMapping(String, Int32),
                            AibStringValue(String, String, String), 
                            UserStatus(String, String)} = #{
        IntValuaEqui(equiId, "User status", s4Status) :- 
            Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("AssetStatus", plinum, aibvalue),
            UserStatus(aibvalue, s4Status).

        UserStatus("DECOMMISSIONED",        "DCOM").
        UserStatus("DISPOSED OF",           "DISP").
        UserStatus("NON OPERATIONAL",       "NOP").
        UserStatus("OPERATIONAL",           "OPER").
        UserStatus("TO BE CONSTRUCTED",     "UCON").

    }

    // Start-up date - todo use flix-time...

    pub def startupDate(): #{DateValuaEqui(Int32, String, String), 
                            Equipment(Int32, String, String, String),
                            EquiMapping(String, Int32),
                            AibDateTimeValue(String, String, String)} = #{
        IntValuaEqui(equiId, "Start-up date", value) :- 
            Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibDateTimeValue("Installed From", plinum, value).

        /// Construction_month, Construction_year
}
