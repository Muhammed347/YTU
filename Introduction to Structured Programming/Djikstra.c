#include<stdio.h>
#define INFINITY 1000
#define MAX 50

//algoritman�n oldu�u fonksiyon
void dijkstra(int dizi[MAX][MAX],int N,int ilk_nokta);

int main(){
	int j,i,N,ilk;
	/*
	N:nokta say�s�, ayn� zamanda dizi matrisinin sat�r ve st�nu say�s� 
	ilk: ilerde scanf ile alaca��m�z iki nokta aras� mesafeyi �lcece�imiz noktalardan ba�lang�c olan�
	*/
	int dizi[MAX][MAX];
	//dizi:noktalar�n birbirine olan uzakl��� yaz�lan matris
	
	printf("toplam nokta say�s�n� giriniz:");
	scanf("%d",&N);
	
	printf("Noktanin kendisine olan uzakligini ve birbirine bagli olmayan noktalar arasi uzakli�i sifir olacak �ekilde matrisi giriniz\n");
	for(i=0;i<N;i++)
	{
		for(j=0;j<N;j++)
		{
			printf("%d\'inci noktanin %d\'inci noktasina olan uzakli�ini giriniz",i+1,j+1);
			scanf("%d",&dizi[i][j]);
		}
	}
	
	//matrisi kod �zerinden direk almak icin asag�s� kullan�labilir ama 15-29. sat�rlar� yorum haline getirmemiz laz�m kullanmak icin
	/*int dizi[MAX][MAX]={{ 0, 4, 0, 0, 0, 0, 0, 8, 0 },
                        { 4, 0, 8, 0, 0, 0, 0, 11, 0 },
                        { 0, 8, 0, 7, 0, 4, 0, 0, 2 },
                        { 0, 0, 7, 0, 9, 14, 0, 0, 0 },
                        { 0, 0, 0, 9, 0, 10, 0, 0, 0 },
                        { 0, 0, 4, 14, 10, 0, 2, 0, 0 },
                        { 0, 0, 0, 0, 0, 2, 0, 1, 6 },
                        { 8, 11, 0, 0, 0, 0, 1, 0, 7 },
                        { 0, 0, 2, 0, 0, 0, 6, 7, 0 } };
    N=9;                    
	*/
	
	printf("baslangic noktasini giriniz(sayilar birden basliyor):");
	scanf("%d",&ilk);
	
	dijkstra(dizi,N,ilk-1);	
	
}

void dijkstra(int dizi[MAX][MAX],int N,int ilk_nokta){
	int maliyet[MAX][MAX],mesafe[MAX],yol[MAX];
	/*
	maliyet[][]:main icerisinde ald���m�z dizi[][] arrayinin d�zenlenecek hali
	mesafe[]:hedef noktaya gidene kadar toplam maliyeti hesaplay�p saklayaca��m�z dizi
	yol[]:hedef noktaya giderekn izledi�imiz rotay� saklayan dizi   
	*/
	
	int visited[MAX],count,min_mesafe,next_nokta,i,j;
	/*
	vizited[]:daha �nce bulunulan noktalar�n takibini tutar
	count:while icin sayac
	min_mesafe:her bir noktan�n �zerinde o ana kadarki maliyetidir. Hesaplanmam�� ise sonsuz
	next_nokta:hesaplanan maliyetler �zerinden gidilecek olan nokta numaras� atan�r 
	*/
	
	
	/*
	parametre olarak ald���m�z dizi arrayin icerisinde atad���m�z '0' degerlerine degeri 1000 olan �nfinity degerini atar ve
	bu yolu cok y�ksek de�erinden dolay� kullanmaz. b�ylece aralar�nda baglant� olmayan iki nokta aras�nda yol yokmu� gibi olur. 
	*/
	for(i=0;i<N;i++)
		for(j=0;j<N;j++)
			if(dizi[i][j]==0)
				maliyet[i][j]=INFINITY;
			else
				maliyet[i][j]=dizi[i][j];
	
	
	/*
	1.noktadan di�er noktalara olan uzakl�klar� mesafe[i]'ye atar daha sonraki while icerisinde en k�c���n� bulup o noktaya do�ru haraket edecek bu sadece
	d�ng�y� ba�latmak icin 
	ayn� �ekilde yol ve visited dizileri de ilk de�erlerini al�r   
	*/
	for(i=0;i<N;i++)
	{
		mesafe[i]=maliyet[ilk_nokta][i];
		yol[i]=ilk_nokta;
		visited[i]=0;
	}
	
	//1. noktam�z�n maliyeti s�f�r, ziyaret edilmi� oldu ve count 1 olarak atan�yor. 
	mesafe[ilk_nokta]=0;
	visited[ilk_nokta]=1;
	count=1;
	
	//algoritma burda ba�l�yor
	//ilk noktay� visit etti�imiz i�in count 1 den ba�l�yor ve son noktadan sonra gidecek ba�ka nokta olmad��� icin while N-1 de bitiyor.
	int sayac=0;
	while(count<N-1)
	{
		//ba�lang��ta b�t�n noktalar�n maliyeti sonsuz 
		min_mesafe=INFINITY;
	
		//bulundu�umuz noktadan sonraki noktalara ziyaret edilmemi� ve minimum mesafesi olan noktay� hepsini kar��la�t�rarak bulur. 
		for(i=0;i<N;i++)
		{
			sayac+=1;
			if(mesafe[i]<min_mesafe&&!visited[i])
			{
				min_mesafe=mesafe[i];
				next_nokta=i;
			}
		}
		//daha iyi bir yol var m� diye bakar�z
		/*
		bunun icin next_nokta ile geldi�imiz noktadan di�er ziyaret edilmemi� noktalar�n maliyeti hesaplanm�� ve bizim �imdiki
		maliyetimizden d���k ise geri d�n�l�p o noktaya gidilir.
		*/
		visited[next_nokta]=1;
		for(i=0;i<N;i++)
			if(!visited[i])
				//asl�nda buraya da saya� eklenebilir ama bu karma��kl��� etkilemeyece�i icin gerek duymad�m. 
				if(min_mesafe+maliyet[next_nokta][i]<mesafe[i])
				{
					mesafe[i]=min_mesafe+maliyet[next_nokta][i];
					yol[i]=next_nokta;
				}
		count++;
	}
	
	//izlenilen rota ve noktaya olan mesafe terminale bast�r�l�r.
	printf("noktalar:\n");
	for (i=0;i<N;i++){
		printf("%d-",i+1);
	}
	
	int iki;
	printf("\nmesafeyi hesaplamak istedi�niz ikinci noktayi giriniz");
	scanf("%d",&iki);
	iki-=1;
	
	printf("\n%d yolunun maliyeti=%d\n",iki+1,mesafe[iki]);
	
	int sira;
	sira=iki;
	printf("========\nyol:\n");
	printf("%d",iki+1);
	do{
		sira=yol[sira];
		printf("<=%d",sira+1);
	}while(sira!=ilk_nokta);
	printf("\nsayac:%d",sayac);
}

