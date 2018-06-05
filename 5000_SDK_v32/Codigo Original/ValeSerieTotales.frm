
[Forma]
Clave=ValeSerieTotales
Icono=0
Modulos=(Todos)
MovModulo=ValeSerieTotales
Nombre=ValeSerieTotales

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=531
PosicionInicialArriba=351
PosicionInicialAlturaCliente=66
PosicionInicialAncho=356
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ValeSerieTotales
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Lista.Registros]
Carpeta=Lista
Clave=Registros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=10
[Lista.Precio]
Carpeta=Lista
Clave=Precio
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20




[Lista.ListaEnCaptura]
(Inicio)=Registros
Registros=Precio
Precio=(Fin)



[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=115
NombreEnBoton=S
NombreDesplegar=Excel(Total)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Excel
ClaveAccion=ExplorarValeSerieTotal
Activo=S
Visible=S





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=(Fin)
