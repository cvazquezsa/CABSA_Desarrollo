[Forma]
Clave=AspelUnidades
Nombre=Unidades de conversión
Icono=131
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=Aceptar
PosicionInicialIzquierda=495
PosicionInicialArriba=295
PosicionInicialAlturaCliente=273
PosicionInicialAncho=582
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Lista(Info.Articulo,Info.Descripcion)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AspelUnidades
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
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
PestanaNombre=Unidades de medida
FiltroGeneral=AspelUnidades.Campo = <T>Unidad<T> AND AspelUnidades.Articulo = <T>{Info.Articulo}<T>

[Lista.AspelUnidades.Valor]
Carpeta=Lista
Clave=AspelUnidades.Valor
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AspelUnidades.Factor]
Carpeta=Lista
Clave=AspelUnidades.Factor
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Valor=304
Factor=105
Multiplo=64
Decimales=64
Peso=64
Volumen=64

[Lista.AspelUnidades.Peso]
Carpeta=Lista
Clave=AspelUnidades.Peso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AspelUnidades.Volumen]
Carpeta=Lista
Clave=AspelUnidades.Volumen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=AspelUnidades.Valor
AspelUnidades.Valor=AspelUnidades.Peso
AspelUnidades.Peso=AspelUnidades.Volumen
AspelUnidades.Volumen=AspelUnidades.Factor
AspelUnidades.Factor=(Fin)
