
%*****CAN DUYAR - 171044075*****%
%**********PART-1***************%

% knowledge base
flight(edirne,edremit).
flight(antalya,istanbul).
flight(istanbul,izmir).
flight(antalya,konya).
flight(antalya,gaziantep).
flight(gaziantep,istanbul).
flight(gaziantep,antalya).
flight(konya,antalya).
flight(konya,ankara).
flight(ankara,konya).
flight(rize,van).
flight(ankara,istanbul).
flight(ankara,van).
flight(van,ankara).
flight(van,istanbul).
flight(rize,istanbul).
flight(izmir,ısparta).
flight(izmir,istanbul).
flight(istanbul,antalya).
flight(istanbul,gaziantep).
flight(istanbul,ankara).
flight(istanbul,van).
flight(istanbul,rize).
flight(van,rize).
flight(edremit,edirne).
flight(edremit,erzincan).
flight(erzincan,edremit).
flight(burdur,ısparta).
flight(ısparta,burdur).
flight(ısparta,izmir).

%rules


between(CityFrom,CityTo,List) :- flight(CityFrom,Between),
not(member(Between, List)), (CityTo = Between; 
betweenroute(Between, CityTo, [CityFrom | List])).


route(X, Y) :- betweenroute(X, Y, []).
betweenroute(X, Y, FlyList) :- between(X,Y,FlyList).

