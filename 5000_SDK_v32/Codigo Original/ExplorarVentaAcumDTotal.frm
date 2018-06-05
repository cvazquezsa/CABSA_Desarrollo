
[Forma]
Clave=ExplorarVentaAcumDTotal
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Totales

ListaCarpetas=Lista
PosicionInicialIzquierda=582
PosicionInicialArriba=328
PosicionInicialAlturaCliente=132
PosicionInicialAncho=485
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
Vista=VentaAcumDTotal
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
CarpetaVisible=S
ListaEnCaptura=(Lista)


[Lista.VentaMes]
Carpeta=Lista
Clave=VentaMes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=15
[Lista.CantidadMes]
Carpeta=Lista
Clave=CantidadMes
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Lista.VentaAcum]
Carpeta=Lista
Clave=VentaAcum
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=15
[Lista.CantidadAcum]
Carpeta=Lista
Clave=CantidadAcum
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Tamano=15
[Lista.Registros]
Carpeta=Lista
Clave=Registros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=Registros
Registros=VentaMes
VentaMes=CantidadMes
CantidadMes=VentaAcum
VentaAcum=CantidadAcum
CantidadAcum=(Fin)

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
NombreDesplegar=&Excel(Total)
EnBarraHerramientas=S
TipoAccion=Reportes Excel
Activo=S
Visible=S





ClaveAccion=VentaAcumDTotalE






EspacioPrevio=S










[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=(Fin)
