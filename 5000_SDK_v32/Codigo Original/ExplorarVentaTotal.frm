
[Forma]
Clave=ExplorarVentaTotal
Icono=47
CarpetaPrincipal=Lista
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Total General

ListaCarpetas=Lista
PosicionInicialIzquierda=350
PosicionInicialArriba=160
PosicionInicialAlturaCliente=165
PosicionInicialAncho=734
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaExclusivaOpcion=0
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
Vista=VentaExplorarTotales
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


[Lista.SubTotalNeto]
Carpeta=Lista
Clave=SubTotalNeto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
EspacioPrevio=S
Pegado=N
[Lista.ImpuestosNetos]
Carpeta=Lista
Clave=ImpuestosNetos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco


Tamano=15
[Lista.ImporteTotalNeto]
Carpeta=Lista
Clave=ImporteTotalNeto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco




Tamano=15
[Lista.SubTotalNetoMN]
Carpeta=Lista
Clave=SubTotalNetoMN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




EspacioPrevio=S
Tamano=15
[Lista.ImpuestosNetosMN]
Carpeta=Lista
Clave=ImpuestosNetosMN
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Lista.ImporteTotalNetoMN]
Carpeta=Lista
Clave=ImporteTotalNetoMN
Editar=S
LineaNueva=N
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



EspacioPrevio=N
Tamano=10








Pegado=N











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
Boton=67
NombreEnBoton=S
NombreDesplegar=Excel(Total)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Excel
ClaveAccion=ExplorarVentaTotales
Activo=S
Visible=S





















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)












[Lista.ListaEnCaptura]
(Inicio)=Registros
Registros=SubTotalNeto
SubTotalNeto=ImpuestosNetos
ImpuestosNetos=ImporteTotalNeto
ImporteTotalNeto=SubTotalNetoMN
SubTotalNetoMN=ImpuestosNetosMN
ImpuestosNetosMN=ImporteTotalNetoMN
ImporteTotalNetoMN=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=(Fin)
