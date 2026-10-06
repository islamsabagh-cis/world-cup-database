#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcupstiff -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# تفريغ الجداول القديمة لضمان عدم تكرار البيانات عند إعادة التشغيل
echo $($PSQL "TRUNCATE TABLE games, teams;")

# قراءة ملف games.csv سطر بسطر (تخطي السطر الأول العناوين)
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    # 1. البحث عن الفريق الفائز (Winner) هل هو موجود مسبقاً؟
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    
    # إذا لم يكن موجوداً، قم بإضافته إلى جدول teams
    if [[ -z $WINNER_ID ]]
    then
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      # جلب الـ ID الخاص به بعد الإضافه
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi

    # 2. البحث عن الفريق المنافس (Opponent) هل هو موجود مسبقاً؟
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    
    # إذا لم يكن موجوداً، قم بإضافته إلى جدول teams
    if [[ -z $OPPONENT_ID ]]
    then
      INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      # جلب الـ ID الخاص به بعد الإضافه
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi

    # 3. إدخال بيانات المباراة في جدول games باستخدام الـ IDs الصحيحة
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
  fi
done