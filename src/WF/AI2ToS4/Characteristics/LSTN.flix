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


    use WF.Base.DataSource
    use WF.Base.DataSource.{ValuaEqui}

    // S4Equipment(equiId = String, name = String, objType = String, classType = String, floc = String, status = String)


    pub def lstnut(): #{AttrString(String, DataSource, String, String), 
                        AttrDecimal(String, DataSource, String, BigDecimal), 
                        S4Equipment(String, String, String, String, String, String),
                        EquiMapping(String, String), 
                        AibStringValue(String, String, String), 
                        AibIntValue(String, String, Int32),
                        AibDecimalValue(String, String, BigDecimal), 
                        RelayFunctionMapping(String, String),
                        RelayOnMapping(String, String),
                        RelayOffMapping(String, String),
                        RangeUnits(String, String),
                        SignalType3(Int32, Int32, String, String)
                        } = #{
        
        AttrString(equiId, ValuaEqui, "LOCATION_ON_SITE", value) :- 
            S4Equipment(equiId, _, "LSTN", "LSTNUT", _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("Location On Site", plinum, value).

        AttrString(equiId, ValuaEqui, "LSTN_TRANSDUCER_MODEL", value) :- 
            S4Equipment(equiId, _, "LSTN", "LSTNUT", _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("Transducer Type", plinum, value).

        AttrString(equiId, ValuaEqui, "LSTN_TRANSDUCER_SERIAL_NO", value) :- 
            S4Equipment(equiId, _, "LSTN", "LSTNUT", _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("Transducer Serial No", plinum, value).

        AttrDecimal(equiId, ValuaEqui, "LSTN_RANGE_MIN", value) :- 
            S4Equipment(equiId, _, "LSTN", "LSTNUT", _, _),
            EquiMapping(plinum, equiId),
            AibDecimalValue("Range min", plinum, value).

        AttrDecimal(equiId, ValuaEqui, "LSTN_RANGE_MAX", value) :- 
            S4Equipment(equiId, _, "LSTN", "LSTNUT", _, _),
            EquiMapping(plinum, equiId),
            AibDecimalValue("Range max", plinum, value).            


        AttrString(equiId, ValuaEqui, "LSTN_RANGE_UNITS", s4Units) :- 
            S4Equipment(equiId, _, "LSTN", "LSTNUT", _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("Range unit", plinum, aibval),
            RangeUnits(aibval, s4Units).

        RangeUnits("cm",    "CM").
        RangeUnits("m",     "MM").
        RangeUnits("mm",    "MM").

        /// TODO "Signal min" / "Signal max" might not be ints
        AttrString(equiId, ValuaEqui, "LSTN_SIGNAL_TYPE", signalType) :- 
            S4Equipment(equiId, _, "LSTN", "LSTNUT", _, _),
            EquiMapping(plinum, equiId),
            AibIntValue("Signal min", plinum, aibmin),
            AibIntValue("Signal max", plinum, aibmax),
            AibStringValue("Signal unit", plinum, aibunits),
            SignalType3(aibmin, aibmax, aibunits, signalType).

        SignalType3(0, 1, "DIGITAL",        "0 - 1 DIGITAL").
        SignalType3(1, 0, "DIGITAL",        "1 - 0 DIGITAL").
        SignalType3(4, 20, "MA",            "4 - 20 MA").

        AttrString(equiId, ValuaEqui, s4RelayFunction, value) :- 
            RelayFunctionMapping(aibRelayFunction, s4RelayFunction),
            S4Equipment(equiId, _, "LSTN", "LSTNUT", _, _),
            EquiMapping(plinum, equiId),
            AibStringValue(aibRelayFunction, plinum, value).

        RelayFunctionMapping("Relay 1 Function", "LSTN_RELAY_1_FUNCTION").
        RelayFunctionMapping("Relay 2 Function", "LSTN_RELAY_2_FUNCTION").
        RelayFunctionMapping("Relay 3 Function", "LSTN_RELAY_3_FUNCTION").
        RelayFunctionMapping("Relay 4 Function", "LSTN_RELAY_4_FUNCTION").
        RelayFunctionMapping("Relay 5 Function", "LSTN_RELAY_5_FUNCTION").
        RelayFunctionMapping("Relay 6 Function", "LSTN_RELAY_6_FUNCTION").

        AttrDecimal(equiId, ValuaEqui, s4RelayOn, value) :- 
            RelayOnMapping(aibRelayOn, s4RelayOn),
            S4Equipment(equiId, _, "LSTN", "LSTNUT", _, _),
            EquiMapping(plinum, equiId),
            AibDecimalValue(aibRelayOn, plinum, value).            

        RelayOnMapping("Relay 1 on Level (m)", "LSTN_RELAY_1_ON_LEVEL_M").
        RelayOnMapping("Relay 2 on Level (m)", "LSTN_RELAY_2_ON_LEVEL_M").
        RelayOnMapping("Relay 3 on Level (m)", "LSTN_RELAY_3_ON_LEVEL_M").
        RelayOnMapping("Relay 4 on Level (m)", "LSTN_RELAY_4_ON_LEVEL_M").
        RelayOnMapping("Relay 5 on Level (m)", "LSTN_RELAY_5_ON_LEVEL_M").
        RelayOnMapping("Relay 6 on Level (m)", "LSTN_RELAY_6_ON_LEVEL_M").

        AttrDecimal(equiId, ValuaEqui, s4RelayOff, value) :- 
            RelayOffMapping(aibRelayOff, s4RelayOff),
            S4Equipment(equiId, _, "LSTN", "LSTNUT", _, _),
            EquiMapping(plinum, equiId),
            AibDecimalValue(aibRelayOff, plinum, value).            

        RelayOffMapping("Relay 1 off Level (m)", "LSTN_RELAY_1_OFF_LEVEL_M").
        RelayOffMapping("Relay 2 off Level (m)", "LSTN_RELAY_2_OFF_LEVEL_M").
        RelayOffMapping("Relay 3 off Level (m)", "LSTN_RELAY_3_OFF_LEVEL_M").
        RelayOffMapping("Relay 4 off Level (m)", "LSTN_RELAY_4_OFF_LEVEL_M").
        RelayOffMapping("Relay 5 off Level (m)", "LSTN_RELAY_5_OFF_LEVEL_M").
        RelayOffMapping("Relay 6 off Level (m)", "LSTN_RELAY_6_OFF_LEVEL_M").
    }



}
