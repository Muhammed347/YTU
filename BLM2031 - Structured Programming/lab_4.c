#include <stdio.h>
#include <stdlib.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */
typedef struct DATA{
	int deger;
	char *field;
	char *field2;
	struct DATA* next;
}data;

void Split_Data(data* holder,char buff[255],char delimiter[2]);
data* File_Read(char File_Name[20],char delimiter[2]);
void Print_List(data* head);


int main(int argc, char *argv[]) {
	data* head;
	head=File_Read("dosya.txt",",\0");
	Print_List(head);
	return 0;
}


data* File_Read(char File_Name[20],char delimiter[2]){
	FILE *fp=fopen(File_Name,"r");
	char buf[255];
	
	struct DATA *head=(data*)malloc(sizeof(data));
	data* curr_data;
	data* prev_data;
	if(fgets(buf,255,fp)!=NULL){
		printf("%s",buf);
		Split_Data(head,buf,delimiter);		
	}
	prev_data=head;
	while(fgets(buf,255,fp)!=NULL){
		printf("%s",buf);
		curr_data=(data*)malloc(sizeof(data));
		prev_data->next=curr_data;
		Split_Data(curr_data,buf,delimiter);
		prev_data=curr_data;
	}
	prev_data->next=NULL;
	fclose(fp);
	return head;
}

void Split_Data(data* holder,char buff[255],char delimiter[2]){
	char *token;
	// strtok(); Delim parametresi ile g�sterilen karakter dizisi i�indeki s�n�rlay�c� karakterleri kullanarak str parametresi ile g�sterilen karakter dizisini par�alara ay�r�r.
	token=strtok(buff,delimiter);
	// atoi(); Str parametresi ile g�sterilen karakter dizisini int bir de�ere �evirir.
	holder->deger=atoi(token);
	// NULL; strtok() fonksiyonuna yap�lan ilk �a�r�, par�alanacak C dizesini iletmelidir 
	// ve sonraki �a�r�lar, ilk arg�man olarak NULL'u belirtmelidir; bu, fonksiyona, ilk olarak iletti�iniz diziyi par�alamaya devam etmesini s�yler.
	holder->field=(char*)malloc(20);
	token=strtok(NULL,delimiter);
	strcpy(holder->field,token);
	holder->field2=(char*)malloc(20);
	token=strtok(NULL,delimiter);
	token[strlen(token)-1]='\0';
	strcpy(holder->field2,token);
	
}


void Print_List(data* head){
	
	while(head!=NULL){
		printf("deger: %d, field1: %s, field2: %s\n",head->deger,head->field,head->field2);
		head=head->next;	
	}
	
}


