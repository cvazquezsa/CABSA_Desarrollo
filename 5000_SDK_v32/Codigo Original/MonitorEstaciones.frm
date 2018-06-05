
[Forma]
Clave=MonitorEstaciones
Icono=0
Modulos=(Todos)
MovModulo=MonitorEstaciones
Nombre=Monitor de Estaciones de Trabajo

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=488
PosicionInicialArriba=147
PosicionInicialAlturaCliente=495
PosicionInicialAncho=613
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MonitorEstaciones
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

CarpetaVisible=S







ListaEnCaptura=(Lista)
MenuLocal=S
ListaAcciones=BorrarRegistro
OtroOrden=S
ListaOrden=UltimaActualizacion<TAB>(Acendente)
[Lista.Columnas]
Estacion=84
EstacionFirma=199
UltimaActualizacion=116
Empresa=53
Sucursal=64
Usuario=64


[Acciones.Cerrar]
Nombre=Cerrar
Boton=36
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





[Acciones.RefrescarVista]
Nombre=RefrescarVista
Boton=82
NombreEnBoton=S
NombreDesplegar=Refrescar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S























[Lista.Estacion]
Carpeta=Lista
Clave=Estacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EstacionFirma]
Carpeta=Lista
Clave=EstacionFirma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=32
ColorFondo=Blanco

[Lista.UltimaActualizacion]
Carpeta=Lista
Clave=UltimaActualizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Empresa]
Carpeta=Lista
Clave=Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.Sucursal]
Carpeta=Lista
Clave=Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Usuario]
Carpeta=Lista
Clave=Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco










[Acciones.BorrarRegistro]
Nombre=BorrarRegistro
Boton=0
NombreDesplegar=Eliminar
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S







Expresion=EjecutarSQL(<T>master.dbo.spEliminarRegistroIntelisisET :tEstacion<T>, MonitorEstaciones:Estacion)<BR>ActualizarVista




[Lista.ListaEnCaptura]
(Inicio)=Estacion
Estacion=EstacionFirma
EstacionFirma=UltimaActualizacion
UltimaActualizacion=Empresa
Empresa=Sucursal
Sucursal=Usuario
Usuario=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=RefrescarVista
RefrescarVista=(Fin)
