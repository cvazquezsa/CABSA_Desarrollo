
[Forma]
Clave=POSCteFacCred
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Clientes Excluidos

ListaCarpetas=POSCteFacCred
CarpetaPrincipal=POSCteFacCred
PosicionInicialIzquierda=547
PosicionInicialArriba=280
PosicionInicialAlturaCliente=273
PosicionInicialAncho=455
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=Aceptar
[POSCteFacCred]
Estilo=Hoja
Clave=POSCteFacCred
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCteFacCred
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)

[POSCteFacCred.POSCteFacCred.Cliente]
Carpeta=POSCteFacCred
Clave=POSCteFacCred.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[POSCteFacCred.Nombre]
Carpeta=POSCteFacCred
Clave=Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata

[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107

[POSCteFacCred.Columnas]
Cliente=64
Nombre=353

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[POSCteFacCred.ListaEnCaptura]
(Inicio)=POSCteFacCred.Cliente
POSCteFacCred.Cliente=Nombre
Nombre=(Fin)
