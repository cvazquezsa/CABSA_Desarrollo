
[Forma]
Clave=MFAContAdicion
Icono=0
Modulos=(Todos)
Nombre=MFA - Adicionar Pólizas

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=396
PosicionInicialAncho=505
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=430
PosicionInicialArriba=147
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Movimiento Especifico
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAContAdicion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S


Pestana=S
[Lista.MFAContAdicion.ModuloID]
Carpeta=Lista
Clave=MFAContAdicion.ModuloID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAContLista.Mov]
Carpeta=Lista
Clave=MFAContLista.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAContLista.MovID]
Carpeta=Lista
Clave=MFAContLista.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar  y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Modulo=50
ModuloID=124
Mov=124
MovID=124
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2



Empresa=45

[Lista.MFAContLista.Empresa]
Carpeta=Lista
Clave=MFAContLista.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=MFAContAdicion.ModuloID
MFAContAdicion.ModuloID=MFAContLista.Empresa
MFAContLista.Empresa=MFAContLista.Mov
MFAContLista.Mov=MFAContLista.MovID
MFAContLista.MovID=(Fin)

[Movimiento]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Movimiento
Clave=Movimiento
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAContOrigenAdicion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
[Movimiento.ListaEnCaptura]
(Inicio)=MFAContOrigenAdicion.OrigenTipo
MFAContOrigenAdicion.OrigenTipo=MFAContOrigenAdicion.Origen
MFAContOrigenAdicion.Origen=MFAContOrigenAdicion.Mov
MFAContOrigenAdicion.Mov=(Fin)

[Movimiento.MFAContOrigenAdicion.OrigenTipo]
Carpeta=Movimiento
Clave=MFAContOrigenAdicion.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Movimiento.MFAContOrigenAdicion.Origen]
Carpeta=Movimiento
Clave=MFAContOrigenAdicion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Movimiento.MFAContOrigenAdicion.Mov]
Carpeta=Movimiento
Clave=MFAContOrigenAdicion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Movimiento.Columnas]
OrigenTipo=95
Origen=147
Mov=178









[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Movimiento
Movimiento=(Fin)
