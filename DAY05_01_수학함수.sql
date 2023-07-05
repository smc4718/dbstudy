-- 1. 절대값
SELECT ABS(-5)  -- -5의 절대값   (절대값을 쓰는 예제 : 좋아요, 싫어요 갯수) , ABS : Absolute Numbers
  FROM DUAL; 



-- 2. 제곱근(루트)
SELECT SQRT(25)  -- 루트 25 는 5
  FROM DUAL;


-- 3. 부호 판별  (숫자 앞에 +인지, -인지, 0인지 판별)
SELECT SIGN(5)   -- 양수는  1
     , SIGN(-5)  -- 음수는 -1
     , SIGN(0)   -- 0
  FROM DUAL;
  
-- 4. 제곱  (2의 10제곱까지 외워두면 좋음, 실제 많이 사용함)   '2 byte = 16 bit가 2의 16제곱임'
SELECT POWER(2,10)  -- 2의 10제곱 : 1024
  FROM DUAL;
  
-- 5. 나머지
SELECT MOD(5,3)   -- 5를 3으로 나눈 나머지 : 2    '값을 순환시킬 때 나머지가 많이 쓰인다. EX)시계:날짜,시간
  FROM DUAL;

-- 6. 정수로 올림
SELECT CEIL(1.1)    -- 1.1보다 큰 정수 : 2         /  CEIL : 천장.
     , CEIL(-1.1)   -- -1보다 큰 정수 : -1
  FROM DUAL;

-- 7. 정수로 내림
SELECT FLOOR(1.9)   -- 1.9보다 작은 정수 :  1      / FLOOR : 바닥
     , FLOOR(-1.9)  -- -1.9보다 작은 정수 : -2
  FROM DUAL;
  
-- 8. 원하는 자릿수로 반올림
SELECT ROUND(123.456)     -- 정수로 반올림 : 123
     , ROUND(123.456, 1)  -- 소수점 1자리에서 반올림 : 123.5 
     , ROUND(123.456, 2)  -- 소수점 2자리에서 반올림 : 123.46
     , ROUND(123.456, -1) -- 일의 자리에서 반올림 : 120
     , ROUND(123.456, -2) -- 십의 자리에서 반올림 : 100
  FROM DUAL;
  
-- 9. 원하는 자릿수로 절사 (절사 : 뒤에 소수점 자리수를 자른다)
SELECT TRUNC(123.456)     -- 123 (정수로 절사)            -- TRUNCATE 의 줄임말 : TRUNC
     , TRUNC(123.456, 1)  -- 123.4 (소수점 1자리로 절사)
     , TRUNC(123.456, 2)  -- 123.45
     , TRUNC(123.456, -1) -- 120
     , TRUNC(123.456, -2) -- 100
  FROM DUAL;


  
  
  
  
  