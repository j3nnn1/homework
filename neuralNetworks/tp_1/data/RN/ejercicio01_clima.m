%clc 
clear
%clf

datos=csvread('G://RN/data/clima_numerico_normalize_oneclassfirst.csv');

%separando training de test

% Porcentaje de Training
porcentaje = 0.8; 

cant_rows = size(datos,1); 
cant_rows_train = fix(porcentaje * cant_rows);

train = datos(1:cant_rows_train, 1:4)';
X = train;
T = datos(1:cant_rows_train,5)';

%obteniendo testing

test = datos(cant_rows_train+1:cant_rows, 1:4)';
T_test = datos(cant_rows_train+1:cant_rows, 5)';

%numero de filas y numero de variables
[Atrib, CantPatrones] = size(train);

alfa = -0.5;
Max_It = 100;
nrow =1;
%inicio variando alfa
while (alfa < 0.6)
    Max_It = 100;
    while (Max_It < 5001)	
        i = 0;
        while (i < 10)
		    %elijo pesos aleatorios.
		    W(1) = 2*rand() -1;
		    W(2) = 2*rand() -1;
		    W(3) = 2*rand() -1;
		    W(4) = 2*rand() -1;

		    %elijo el umbral aleatorio. esto permite discernir sobre la salida
		    b = rand();

		    Ite = 0;
		    hubo_cambio=1;

		    %perceptron
		    while ((Ite < Max_It) && (hubo_cambio==1))
			    hubo_cambio=0;
			
			    for patr = 1: CantPatrones

				    neta = W*X(:, patr)+b;

				    salida = (neta > 0);
			   
				    if (T(patr)~=salida) 
					    hubo_cambio = 1;
					    sprintf('cambia alguna vez los pesos ');
					    W = W + alfa * (T(patr)-salida)*X(:,patr)';
					    b = b + alfa * T(patr)-salida;
                    end
                end
			
			Ite = Ite +1;
            end

		    %guardo los pesos (W) y el umbral (b) 
            %sprintf('Finalizo en = %d', Ite)
            %sprintf('max iteracion = %d', Max_It)
            %sprintf('W1 = %d', W(1))
            %sprintf('W1 = %d', W(2))
            %sprintf('b = %d', b)
		
		    titulo = strcat('RN_clima_numerico_normalize_oneclassfirst', num2str(alfa));
            titulo = num2str(titulo);
            %guardo los pesos (W) y el umbral (b) 
            save(titulo);

		    %load RN_clima

		    Aciertos = 0;

		    [atrib, CantPatrones] = size(test);

		    for patr = 1:CantPatrones
			    neta = W*test(:, patr)+b;
			    salida = (neta > 0);
			    %sprintf('cant salida = %d', salida)
			    %sprintf('cant T_test = %d', T_test(patr))
			    if (salida ==T_test(patr))
				    Aciertos = Aciertos +1;
                end
            end
		
		    %creando matrix
            csv(nrow,:) = [i, nrow, alfa, Max_It, b, W(1), W(2), W(3), W(4), Ite, Aciertos];
            nrow = nrow + 1;
            %sprintf('alfa = %d', alfa)
		    %sprintf('cant aciertos = %d', Aciertos)
		    %maximo numero de iteraciones
            Max_It = Max_It + 100;
            i = i + 1;
        end
    end
	%porcentaje con el cual va a aprender
    alfa = alfa + 0.1;
    
end
csvwrite(titulo, csv);
