function [arreglo,intervalo]= routh(ec)

syms k1 k2 E k

h=length(ec);
a=h/2;

if mod(h,2) == 0
    
        %Pares 
        arreglo=zeros(h,a,'sym');

        %Para llenar los valores a del arreglo
            columna=1;
            for i=1:a
            arreglo(1,i) = ec(columna);
            
               if  arreglo(1,i) == 0
                    arreglo(1,i)=E;
               end
            columna=columna+2;
            end

            columna=2;
            for j=1:a
                 arreglo(2,j) = ec(columna);
                 
                 if  arreglo(2,j) == 0
                    arreglo(2,j)=E;
                 end
                 columna=columna+2;
            end
            
         %Para calcular b

            %for g=1:a-1
               % arreglo(3,g) =  ( arreglo(2,1)*arreglo(1,g+1) - arreglo(1,1)*arreglo(2,g+1) )/arreglo(2,1);
                
               % if  arreglo(3,g) == 0
                   % arreglo(3,g)=E;
                %end
                
           % end 
   
            
        %Para calcular los demás 
            o=2;
            x=a-1;
            
         for w=3:h
               
                for g=1:a-1
                    arreglo(w,g) =  ( arreglo(w-1,1)*arreglo(w-2,g+1) - arreglo(w-2,1)*arreglo(w-1,g+1) )/arreglo(w-1,1);
                     
                    
                    %if  arreglo(w,g) == 0 %&& w~=h && w~=h-1
                     %   arreglo(w,g)=E;
                    %end
                                
                end
                            if arreglo(w,:)==0
                                
                                order=(h-w+1);
                                c=0;
                                d=1;
                                for j=1:a-1
                                    arreglo(w,j)=(order-c)*(arreglo(w-1,d));
                                    d=d+1;
                                    c=c+2;
                                end
                                %caso='Fila completa llena de ceros'
                                
                            else 
                                     if o < h && x>0

                                            for f=o:o+1
                                                for t=1:x
                                                       if  arreglo(f,t) == 0 
                                                           arreglo(f,t)=E;
                                                           %caso='Casilla con cero'
                                                       end
                                                end
                                            end 
                                            o=o+2;
                                            x=x-1;
                                     end
                            end 
         end 
                
         
         
        
else 
        %Impares 
        arreglo=zeros(h,fix(a)+1,'sym');

        %Para llenar los valores a del arreglo
            columna=1;
            for i=1:fix(a)+1
               arreglo(1,i) = ec(columna);
               
               if  arreglo(1,i) == 0
                    arreglo(1,i)=E;
               end
               columna=columna+2;
            end

            columna=2;
            for j=1:fix(a)
               arreglo(2,j) = ec(columna);
               
               if  arreglo(2,j) == 0
                    arreglo(2,j)=E;
               end
               columna=columna+2;
            end
    
          
        %Para calcular b
           % for g=1:fix(a)
             %   arreglo(3,g) =  ( arreglo(2,1)*arreglo(1,g+1) - arreglo(1,1)*arreglo(2,g+1) )/arreglo(2,1);
                
              %  if  arreglo(3,g) == 0
              %      arreglo(3,g)=E;
                    
              %  end
           % end 
            
            o=2;
            x=fix(a);
            for w=3:h
                for g=1:fix(a)
                    arreglo(w,g) =  ( arreglo(w-1,1)*arreglo(w-2,g+1) - arreglo(w-2,1)*arreglo(w-1,g+1) )/arreglo(w-1,1);
                    
                    
                            %if o < h && x>0
                                
                             %   for f=o:o+1
                              %      for t=1:x
                               %            if  arreglo(f,t) == 0 
                                %               arreglo(f,t)=E;
                                 %          end
                                  %  end
                              %  end 
                               % o=o+2;
                             %   x=x-1;
                           % end
                            
                end
                            if arreglo(w,:)==0
                                
                                order=(h-w+1);
                                c=0;
                                d=1;
                                for j=1:fix(a)-1
                                    arreglo(w,j)=(order-c)*(arreglo(w-1,d));
                                    d=d+1;
                                    c=c+2;
                                end
                                %caso='Fila completa llena de ceros'
                                
                            else 
                                     if o < h && x>0

                                            for f=o:o+1
                                                for t=1:x
                                                       if  arreglo(f,t) == 0 
                                                           arreglo(f,t)=E;
                                                           %caso='Casilla con cero'
                                                       end
                                                end
                                            end 
                                            o=o+2;
                                            x=x-1;
                                     end
                            end 
            end   
        
            
           
end


poles=0; 
for i=1:h-1
    if sign(arreglo(i,1))*sign(arreglo(i+1,1))==-1
        poles=poles+1;
    end
end



%----------------------------------------------------------------------------------------------------
%y1=Arreglo(m,1)
%y2=Arreglo(m-1,1)
%z1=solve(y1,k1)
%z2=solve(y2,k1)
%INTERVALO=[z1 z2]
%columna=sym(0)


columna=arreglo(:,1);
rango=solve(columna>0,k,'ReturnConditions',true);
intervalo=rango.conditions;
%regionEstable=evalc('rango')
%str=['',regionEstable(13:end)]



%y1=arreglo(h-1,1)
%y2=arreglo(h,1)
%y=[y1;y2]
%z1=solve(y1==0,k)

%z2=solve(y2==0,k)
%int=solve(y==0,k)
%INTERVALO=[z1 z2]