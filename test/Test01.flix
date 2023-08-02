@test
def testTemp01(): Bool = 
    Regex.endsWith(suffix = regex"(?i)\\(Del\\)", "Pump-1 (Del)")

@test
def testTemp02(): Bool = 
    Regex.endsWith(suffix = regex"(?i)\\(Del\\)", "Pump-1 (DEL)")

@test
def test01(): Unit \ IO = 
    let equis = List#{(10112, "Pump-1 (Del)", "DISP", "0010"), (10113, "Pump-1", "DISP", "0020")};
    let db = inject equis into Equipment;
    let answers = 
        query db, Rules1.dispIsDel() 
        select (msg, equiId, name) from CheckError(msg, equiId, name);
    Vector.forEach(println, answers)
