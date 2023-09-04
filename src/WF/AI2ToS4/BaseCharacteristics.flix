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

mod WF.AI2ToS4.BaseCharacteristics {

    // Equipment(equiId = Int32, name = String, Floc = String, status = String)

    pub def easting(): #{IntValuaEqui(Int32, String, Int32), 
                            S4Equipment(Int32, String, String, String),
                            EquiMapping(String, Int32), 
                            AibParent(String, String),
                            AibStringValue(String, String, String)} = #{
        IntValuaEqui(equiId, "EASTING", WF.Base.Osgb36.eastingfromOsgb36(gridref)) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibParent(plinum, sainum),
            AibStringValue("Loc.Ref.", sainum, gridref).
    }

    pub def northing(): #{IntValuaEqui(Int32, String, Int32), 
                            S4Equipment(Int32, String, String, String),
                            EquiMapping(String, Int32), 
                            AibParent(String, String),
                            AibStringValue(String, String, String)} = #{
        IntValuaEqui(equiId, "NORTHING", WF.Base.Osgb36.northingfromOsgb36(gridref)) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibParent(plinum, sainum),
            AibStringValue("Loc.Ref.", sainum, gridref).
    }



    pub def conditionGrade(): #{StringValuaEqui(Int32, String, String), 
                                S4Equipment(Int32, String, String, String),
                                EquiMapping(String, Int32), 
                                AibStringValue(String, String, String),
                                ConditionGrade(String, String)
                                } = #{
        StringValuaEqui(equiId, "CONDITION_GRADE", s4Grade) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("Condition Grade", plinum, aibval),
            ConditionGrade(aibval, s4Grade).

        ConditionGrade("1 - Good",      "1 - GOOD").
        ConditionGrade("2 - Fair",      "2 - FAIR").
        ConditionGrade("3 - Adequate",  "3 - ADEQUATE").
        ConditionGrade("4 - Poor",      "4 - POOR").
        ConditionGrade("5 - Awful",     "5 - AWFUL").
    
        StringValuaEqui(equiId, "CONDITION_GRADE_REASON", String.toUpperCase(reason)) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("Condition Grade Reason", plinum, reason).
    }

    pub def loadingFactor(): #{StringValuaEqui(Int32, String, String), 
                                S4Equipment(Int32, String, String, String),
                                EquiMapping(String, Int32), 
                                AibStringValue(String, String, String),
                                LoadingFactor(String, String)
                                } = #{
        StringValuaEqui(equiId, "LOADING_FACTOR", s4Loading) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("Loading Factor", plinum, aibval),
            LoadingFactor(aibval, s4Loading).

        LoadingFactor("1 - Significantly Under Loaded",     "1 - SIGNIFICANTLY UNDER LOADED").
        LoadingFactor("2 - Under Loaded",                   "2 - UNDER LOADED").
        LoadingFactor("3 - Satisfactory",                   "3 - SATISFACTORY").
        LoadingFactor("4 - Overloaded",                     "4 - OVERLOADED").
        LoadingFactor("5 - Unacceptable",                   "5 - UNACCEPTABLE").

        StringValuaEqui(equiId, "LOADING_FACTOR_REASON", String.toUpperCase(reason)) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("Loading Factor Reason", plinum, reason).
    }

    pub def performanceGrade(): #{StringValuaEqui(Int32, String, String), 
                                S4Equipment(Int32, String, String, String),
                                EquiMapping(String, Int32), 
                                AibStringValue(String, String, String),
                                PerformanceGrade(String, String)
                                } = #{
        StringValuaEqui(equiId, "PERFORMANCE_GRADE", s4Grade) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("Performance Grade", plinum, aibval),
            PerformanceGrade(aibval, s4Grade).

        PerformanceGrade("1 - Availability  95%",       "1 - AVAILABILITY 95%").
        PerformanceGrade("2 - Availability 90% - 94%",  "2 - AVAILABILITY 90% - 94%").
        PerformanceGrade("3 - Availability 80% - 89%",  "3 - AVAILABILITY 80% - 89%").
        PerformanceGrade("4 - Availability 50% - 79%",  "4 - AVAILABILITY 50% - 79%").
        PerformanceGrade("5 - Availability  49%",       "5 - AVAILABILITY 49%").

        StringValuaEqui(equiId, "PERFORMANCE_GRADE_REASON", String.toUpperCase(reason)) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibStringValue("Performance Grade Reason", plinum, reason).
    }

    pub def surveyDate(): #{IntValuaEqui(Int32, String, Int32), 
                            S4Equipment(Int32, String, String, String),
                            EquiMapping(String, Int32), 
                            AibIntValue(String, String, Int32)} = #{
        /// NOTE in Aib this is called "SURVEY_YEAR"
        IntValuaEqui(equiId, "SURVEY_DATE", year) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibIntValue("Survey Year", plinum, year).
    }

    pub def aibReference(): #{StringValuaEqui(Int32, String, String), 
                            S4Equipment(Int32, String, String, String),
                            EquiMapping(String, Int32), 
                            AibParent(String, String)} = #{
        StringValuaEqui(equiId, "AI2_AIB_REFERENCE", plinum) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId).

        StringValuaEqui(equiId, "AI2_AIB_REFERENCE", sainum) :- 
            S4Equipment(equiId, _, _, _),
            EquiMapping(plinum, equiId),
            AibParent(plinum, sainum).
    }

}
