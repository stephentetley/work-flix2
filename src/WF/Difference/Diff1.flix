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


    pub def diffMasterData(): #{DiffMasterDataString(String, String, String, Diff[String]),
                                DiffMasterDataInt(String, String, String, Diff[Int32]),
                                DiffMasterDataDecimal(String, String, String, Diff[BigDecimal]),
                                DiffMasterDataDate(String, String, String, Diff[Time.LocalDate]),
                                S4Equipment(String, String, String, String, String, String),
                                Matches(String, String),
                                HasMasterDataString(String, String),
                                HasMasterDataInt(String, String),
                                HasMasterDataDecimal(String, String),
                                MasterDataString(String, String, String),
                                MasterDataInt(String, String, Int32),
                                MasterDataDecimal(String, String, BigDecimal)} = #{

        DiffMasterDataString(equiId, otherId, charName, if (value != otherValue) Diff(value, otherValue) else Same(value)) :- 
            S4Equipment(equiId, _, _, _, _, _),
            MasterDataString(equiId, charName, value), 
            Matches(equiId, otherId),
            MasterDataString(otherId, charName, otherValue).

        /// TODO is having MasterData__ and ValuaEqui__ making too many relations?
    }

    pub def diffValuaEqui(): #{DiffValuaEquiString(String, String, String, Diff[String]),
                                DiffValuaEquiInt(String, String, String, Diff[Int32]),
                                DiffValuaEquiDecimal(String, String, String, Diff[BigDecimal]),
                                S4Equipment(String, String, String, String, String, String),
                                Matches(String, String),
                                HasValuaEquiString(String, String),
                                HasValuaEquiInt(String, String),
                                HasValuaEquiDecimal(String, String),
                                ValuaEquiString(String, String, String),
                                ValuaEquiInt(String, String, Int32),
                                ValuaEquiDecimal(String, String, BigDecimal)} = #{

        DiffValuaEquiString(equiId, otherId, charName, if (value != otherValue) Diff(value, otherValue) else Same(value)) :- 
            S4Equipment(equiId, _, _, _, _, _),
            ValuaEquiString(equiId, charName, value), 
            Matches(equiId, otherId),
            ValuaEquiString(otherId, charName, otherValue).

        HasValuaEquiString(equiId, charName) :- ValuaEquiString(equiId, charName, _).

        DiffValuaEquiString(equiId, otherId, charName, Add(otherValue)) :-
            S4Equipment(equiId, _, _, _, _, _),
            Matches(equiId, otherId),
            ValuaEquiString(otherId, charName, otherValue),
            not HasValuaEquiString(equiId, charName).

        DiffValuaEquiString(equiId, otherId, charName, Del(value)) :-
            S4Equipment(equiId, _, _, _, _, _),
            Matches(equiId, otherId),
            ValuaEquiString(equiId, charName, value),
            not HasValuaEquiString(otherId, charName).

        DiffValuaEquiInt(equiId, otherId, charName, if (value != otherValue) Diff(value, otherValue) else Same(value)) :- 
            S4Equipment(equiId, _, _, _, _, _),
            ValuaEquiInt(equiId, charName, value), 
            Matches(equiId, otherId),
            ValuaEquiInt(otherId, charName, otherValue), 
            if value != otherValue.

        HasValuaEquiInt(equiId, charName) :- ValuaEquiInt(equiId, charName, _).

        DiffValuaEquiInt(equiId, otherId, charName, Add(otherValue)) :-
            S4Equipment(equiId, _, _, _, _, _),
            Matches(equiId, otherId),
            ValuaEquiInt(otherId, charName, otherValue),
            not HasValuaEquiInt(equiId, charName).

        DiffValuaEquiInt(equiId, otherId, charName, Del(value)) :-
            S4Equipment(equiId, _, _, _, _, _),
            Matches(equiId, otherId),
            ValuaEquiInt(equiId, charName, value),
            not HasValuaEquiInt(otherId, charName).


        DiffValuaEquiDecimal(equiId, otherId, charName, if (value != otherValue) Diff(value, otherValue) else Same(value)) :- 
            S4Equipment(equiId, _, _, _, _, _),
            ValuaEquiDecimal(equiId, charName, value), 
            Matches(equiId, otherId),
            ValuaEquiDecimal(otherId, charName, otherValue), 
            if value != otherValue.

        HasValuaEquiDecimal(equiId, charName) :- ValuaEquiDecimal(equiId, charName, _).

        DiffValuaEquiDecimal(equiId, otherId, charName, Add(otherValue)) :-
            S4Equipment(equiId, _, _, _, _, _),
            Matches(equiId, otherId),
            ValuaEquiDecimal(otherId, charName, otherValue),
            not HasValuaEquiDecimal(equiId, charName).

        DiffValuaEquiDecimal(equiId, otherId, charName, Del(value)) :-
            S4Equipment(equiId, _, _, _, _, _),
            Matches(equiId, otherId),
            ValuaEquiDecimal(equiId, charName, value),
            not HasValuaEquiDecimal(otherId, charName).

    } 


}
