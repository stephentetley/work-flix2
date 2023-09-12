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

    use WF.Base.DataSource
    use WF.Difference.Diff
    use WF.Difference.Diff.{Add, Del, Diff, Same}

    // Diffing betwen two s4 records - one is expected to have a dollar Id (?)

    // S4Equipment(equiId = String, name = String, objType = String, classType = String, floc = String, status = String)


    pub def diffAttr(): #{DiffAttrString(String, String, DataSource, String, Diff[String]),
                            DiffAttrInt(String, String, DataSource, String, Diff[Int32]),
                            DiffAttrDecimal(String, String, DataSource, String, Diff[BigDecimal]),
                            S4Equipment(String, String, String, String, String, String),
                            SameEquiItem(String, String),
                            HasAttrString(String, DataSource, String),
                            HasAttrInt(String, DataSource, String),
                            HasAttrDecimal(String, DataSource, String),
                            AttrString(String, DataSource, String, String),
                            AttrInt(String, DataSource, String, Int32),
                            AttrDecimal(String, DataSource, String, BigDecimal)} = #{

        DiffAttrString(equiId, otherId, source, charName, if (value != otherValue) Diff(value, otherValue) else Same(value)) :- 
            S4Equipment(equiId, _, _, _, _, _),
            AttrString(equiId, source, charName, value), 
            SameEquiItem(equiId, otherId),
            AttrString(otherId, source, charName, otherValue).

        HasAttrString(equiId, source, charName) :- AttrString(equiId, source, charName, _).

        DiffAttrString(equiId, otherId, source, charName, Add(otherValue)) :-
            S4Equipment(equiId, _, _, _, _, _),
            SameEquiItem(equiId, otherId),
            AttrString(otherId, source, charName, otherValue),
            not HasAttrString(equiId, source, charName).

        DiffAttrString(equiId, otherId, source, charName, Del(value)) :-
            S4Equipment(equiId, _, _, _, _, _),
            SameEquiItem(equiId, otherId),
            AttrString(equiId, source, charName, value),
            not HasAttrString(otherId, source, charName).

        DiffAttrInt(equiId, otherId, source, charName, if (value != otherValue) Diff(value, otherValue) else Same(value)) :- 
            S4Equipment(equiId, _, _, _, _, _),
            AttrInt(equiId, source, charName, value), 
            SameEquiItem(equiId, otherId),
            AttrInt(otherId, source, charName, otherValue), 
            if value != otherValue.

        HasAttrInt(equiId, source, charName) :- AttrInt(equiId, source, charName, _).

        DiffAttrInt(equiId, otherId, source, charName, Add(otherValue)) :-
            S4Equipment(equiId, _, _, _, _, _),
            SameEquiItem(equiId, otherId),
            AttrInt(otherId, source, charName, otherValue),
            not HasAttrInt(equiId, source, charName).

        DiffAttrInt(equiId, otherId, source, charName, Del(value)) :-
            S4Equipment(equiId, _, _, _, _, _),
            SameEquiItem(equiId, otherId),
            AttrInt(equiId, source, charName, value),
            not HasAttrInt(otherId, source, charName).


        DiffAttrDecimal(equiId, otherId, source, charName, if (value != otherValue) Diff(value, otherValue) else Same(value)) :- 
            S4Equipment(equiId, _, _, _, _, _),
            AttrDecimal(equiId, source, charName, value), 
            SameEquiItem(equiId, otherId),
            AttrDecimal(otherId, source, charName, otherValue), 
            if value != otherValue.

        HasAttrDecimal(equiId, source, charName) :- AttrDecimal(equiId, source, charName, _).

        DiffAttrDecimal(equiId, otherId, source, charName, Add(otherValue)) :-
            S4Equipment(equiId, _, _, _, _, _),
            SameEquiItem(equiId, otherId),
            AttrDecimal(otherId, source, charName, otherValue),
            not HasAttrDecimal(equiId, source, charName).

        DiffAttrDecimal(equiId, otherId, source, charName, Del(value)) :-
            S4Equipment(equiId, _, _, _, _, _),
            SameEquiItem(equiId, otherId),
            AttrDecimal(equiId, source, charName, value),
            not HasAttrDecimal(otherId, source, charName).

    } 


}
