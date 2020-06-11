%% Part 1 : Import the Image

I_Leena = imread('Minion.png');
I_Leena = rgb2gray(I_Leena);
figure(1); title('Original Image'); imshow(I_Leena);

%% Part 2 : Design the Filters

HPF = [-1,-1,-1;-1,8,-1;-1,-1,-1];

LPF = [1,1,1;1,1,1;1,1,1] .* (1/9);


%% Part 3 : Apply the Filters

I_Leena_HPF = conv2(I_Leena,HPF);
I_Leena_LPF = conv2(I_Leena,LPF);
figure(2);
subplot(121); imshow(uint8(I_Leena_HPF)); title("Leena - HPF (Observe the Edges)");
subplot(122); imshow(uint8(I_Leena_LPF)); title("Leena - LPF (Observe the Blur Effect)");
