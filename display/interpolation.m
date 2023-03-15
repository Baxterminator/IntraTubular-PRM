function qSet_new = interpolation(qSet,n)
    qSet_new = [];
    for j=1:size(qSet,1)-1
        q1 = qSet(j,:);
        q2 = qSet(j+1,:);
        l_q = [q1];
        for i=1:n
            signt1 = sign(q1(3)-q2(3));
            qi = q1+((i+1)/(n+2))*(q2-q1);
            if(abs(q1(3)-q2(3))>abs(q1(3)-q2(3)-signt1*2*pi))
                qi(3) = q1(3)+((i+1)/(n+2))*(q2(3)-q1(3)+signt1*2*pi);
            end
            l_q=[l_q;qi];
        end
        qSet_new=[qSet_new;l_q];
    end
end