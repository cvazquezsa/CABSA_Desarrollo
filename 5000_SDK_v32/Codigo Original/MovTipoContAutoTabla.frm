[Forma]
Clave=MovTipoContAutoTabla
Nombre=Tabla
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=710
PosicionInicialArriba=445
PosicionInicialAlturaCliente=273
PosicionInicialAncho=554
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(e(<T>Empresa<T>)+<T>: <T>+Info.Empresa, Info.Nombre)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoContAutoTabla
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=(Lista)

FiltroGeneral=MovTipoContAutoTabla.Empresa=<T>{Info.Empresa}<T> AND<BR>MovTipoContAutoTabla.Modulo=<T>{Info.Modulo}<T> AND<BR>MovTipoContAutoTabla.Clave=<T>{Info.Clave}<T> AND<BR>MovTipoContAutoTabla.Nombre=<T>{Info.Nombre}<T>
[Lista.MovTipoContAutoTabla.Porcentaje]
Carpeta=Lista
Clave=MovTipoContAutoTabla.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoContAutoTabla.Cuenta]
Carpeta=Lista
Clave=MovTipoContAutoTabla.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Columnas]
Porcentaje=40
Cuenta=171
Descripcion=258
Excento=45

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

[Lista.MovTipoContAutoTabla.Excento]
Carpeta=Lista
Clave=MovTipoContAutoTabla.Excento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro



[Lista.ListaEnCaptura]
(Inicio)=MovTipoContAutoTabla.Porcentaje
MovTipoContAutoTabla.Porcentaje=MovTipoContAutoTabla.Excento
MovTipoContAutoTabla.Excento=MovTipoContAutoTabla.Cuenta
MovTipoContAutoTabla.Cuenta=Cta.Descripcion
Cta.Descripcion=(Fin)

[Lista.ListaOrden]
(Inicio)=MovTipoContAutoTabla.Porcentaje	(Acendente)
MovTipoContAutoTabla.Porcentaje	(Acendente)=MovTipoContAutoTabla.Excento	(Decendente)
MovTipoContAutoTabla.Excento	(Decendente)=(Fin)
