[Forma]
Clave=DepartamentoDetallista
Nombre=Departamentos (Sistema Detallista)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=385
PosicionInicialArriba=286
PosicionInicialAlturaCliente=425
PosicionInicialAncho=510
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DepartamentoDetallista
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

[Lista.DepartamentoDetallista.Nombre]
Carpeta=Lista
Clave=DepartamentoDetallista.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
DepartamentoDetallista=78
Nombre=339
Departamento=73
Merma=66

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.DepartamentoDetallista.Departamento]
Carpeta=Lista
Clave=DepartamentoDetallista.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DepartamentoDetallista.Merma]
Carpeta=Lista
Clave=DepartamentoDetallista.Merma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=DepartamentoDetallista.Departamento
DepartamentoDetallista.Departamento=DepartamentoDetallista.Nombre
DepartamentoDetallista.Nombre=DepartamentoDetallista.Merma
DepartamentoDetallista.Merma=(Fin)
