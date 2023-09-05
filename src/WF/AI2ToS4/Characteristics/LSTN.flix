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

mod WF.AI2ToS4.Characteristics.LSTN {

    // S4Equipment(equiId = String, name = String, Floc = String, status = String)

    pub def locationOnSite(): #{ValuaEquiString(String, String, String), 
                            S4Equipment(String, String, String, String),
                            EquiMapping(String, String), 
                            AibParent(String, String),
                            AibStringValue(String, String, String)} = #{
        ValuaEquiString(equiId, "LOCATION_ON_SITE", value) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibParent(plinum, sainum),
            AibStringValue("Location On Site", sainum, value).
    }

    


    pub def lstnut(): #{ValuaEquiString(String, String, String), 
                            ValuaEquiDecimal(String, String, Float64), 
                            S4Equipment(String, String, String, String),
                            EquiMapping(String, String), 
                            AibParent(String, String),
                            AibStringValue(String, String, String), 
                            AibDecimalValue(String, String, Float64), 
                            RelayFunctionMapping(String, String),
                            RelayOnMapping(String, String),
                            RelayOffMapping(String, String)
                            } = #{

        ValuaEquiString(equiId, "LSTN_TRANSDUCER_MODEL", value) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibParent(plinum, sainum),
            AibStringValue("Transducer Type", sainum, value).

        ValuaEquiString(equiId, "LSTN_TRANSDUCER_SERIAL_NO", value) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibParent(plinum, sainum),
            AibStringValue("Transducer Serial No", sainum, value).

        ValuaEquiDecimal(equiId, "LSTN_RANGE_MIN", value) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibParent(plinum, sainum),
            AibDecimalValue("Range min", sainum, value).

        ValuaEquiDecimal(equiId, "LSTN_RANGE_MAX", value) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibParent(plinum, sainum),
            AibDecimalValue("Range max", sainum, value).            


// Range unit


        ValuaEquiString(equiId, s4RelayFunction, value) :- 
            RelayFunctionMapping(aibRelayFunction, s4RelayFunction),
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibParent(plinum, sainum),
            AibStringValue(aibRelayFunction, sainum, value).

        RelayFunctionMapping("Relay 1 Function", "LSTN_RELAY_1_FUNCTION").
        RelayFunctionMapping("Relay 2 Function", "LSTN_RELAY_2_FUNCTION").
        RelayFunctionMapping("Relay 3 Function", "LSTN_RELAY_3_FUNCTION").
        RelayFunctionMapping("Relay 4 Function", "LSTN_RELAY_4_FUNCTION").
        RelayFunctionMapping("Relay 5 Function", "LSTN_RELAY_5_FUNCTION").
        RelayFunctionMapping("Relay 6 Function", "LSTN_RELAY_6_FUNCTION").

        ValuaEquiDecimal(equiId, s4RelayOn, value) :- 
            RelayOnMapping(aibRelayOn, s4RelayOn),
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibParent(plinum, sainum),
            ValuaEquiDecimal(aibRelayOn, sainum, value).            

        RelayOnMapping("Relay 1 on Level (m)", "LSTN_RELAY_1_ON_LEVEL_M").
        RelayOnMapping("Relay 2 on Level (m)", "LSTN_RELAY_2_ON_LEVEL_M").
        RelayOnMapping("Relay 3 on Level (m)", "LSTN_RELAY_3_ON_LEVEL_M").
        RelayOnMapping("Relay 4 on Level (m)", "LSTN_RELAY_4_ON_LEVEL_M").
        RelayOnMapping("Relay 5 on Level (m)", "LSTN_RELAY_5_ON_LEVEL_M").
        RelayOnMapping("Relay 6 on Level (m)", "LSTN_RELAY_6_ON_LEVEL_M").

        ValuaEquiDecimal(equiId, s4RelayOff, value) :- 
            RelayOffMapping(aibRelayOff, s4RelayOff),
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibParent(plinum, sainum),
            ValuaEquiDecimal(aibRelayOff, sainum, value).            

        RelayOffMapping("Relay 1 off Level (m)", "LSTN_RELAY_1_OFF_LEVEL_M").
        RelayOffMapping("Relay 2 off Level (m)", "LSTN_RELAY_2_OFF_LEVEL_M").
        RelayOffMapping("Relay 3 off Level (m)", "LSTN_RELAY_3_OFF_LEVEL_M").
        RelayOffMapping("Relay 4 off Level (m)", "LSTN_RELAY_4_OFF_LEVEL_M").
        RelayOffMapping("Relay 5 off Level (m)", "LSTN_RELAY_5_OFF_LEVEL_M").
        RelayOffMapping("Relay 6 off Level (m)", "LSTN_RELAY_6_OFF_LEVEL_M").
    }



}
