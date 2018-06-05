
[Forma]
Clave=SAUXServIndicador
Icono=0
CarpetaPrincipal=Ficha
BarraHerramientas=S
Modulos=(Todos)
Nombre=Indicadores del Servicio
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Ficha
PosicionInicialAlturaCliente=273
PosicionInicialAncho=569
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=515
PosicionInicialArriba=294
Comentarios=Lista(Info.Servicio, Info.Descripcion)
ListaAcciones=(Lista)
[Ficha]
Estilo=Hoja
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SAUXServIndicador
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

PestanaOtroNombre=S
PestanaNombre=Indicadores
FiltroGeneral=SAUXServIndicador.Servicio = <T>{Info.Servicio}<T>
[Ficha.SAUXServIndicador.Indicador]
Carpeta=Ficha
Clave=SAUXServIndicador.Indicador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Ficha.Columnas]
Servicio=124
Indicador=109
Tipo=184
Minimo=64
Maximo=64


Descripcion=419
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

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
















[Lista.Columnas]
Indicador=124
Descripcion=604



[Ficha.Descripcion]
Carpeta=Ficha
Clave=Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata




[Ficha.ListaEnCaptura]
(Inicio)=SAUXServIndicador.Indicador
SAUXServIndicador.Indicador=Descripcion
Descripcion=(Fin)














[Acciones.SAUXIndicador]
Nombre=SAUXIndicador
Boton=39
NombreEnBoton=S
NombreDesplegar=&Indicadores
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=SAUXIndicador
Activo=S
Visible=S





GuardarAntes=S





[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S





















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=SAUXIndicador
SAUXIndicador=Excel
Excel=(Fin)
