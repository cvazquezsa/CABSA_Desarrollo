[Forma]
Clave=CuboContDW
Nombre=<T>Analizar - Detalle Contable<T>
Icono=4
Modulos=(Todos)
ListaCarpetas=Cubo
CarpetaPrincipal=Cubo
PosicionInicialIzquierda=484
PosicionInicialArriba=253
PosicionInicialAlturaCliente=617
PosicionInicialAncho=900
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Cubo.VistaNombre(<T>Cubo<T>), Info.Descripcion)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
ExpresionesAlMostrar=Forma.CuboVistaPorOmision(Info.Cuenta)

[Cubo]
Estilo=Cubo
Clave=Cubo
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContDW
Fuente={Tahoma, 8, Negro, []}
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=ContDW.Empresa=<T>{Empresa}<T> AND ContDW.Cuenta=<T>{Info.Cuenta}<T>

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Cubo.Personalizar(<T>Cubo<T>)
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=<T>Guardar como Hoja E&xcel...<T>
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Cubo.GuardarComoExcel(<T>Cubo<T>)

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=<T>Guardar Vista<T>
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Cubo.GuardarVistaActual(<T>Cubo<T>)
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=Guardar
Guardar=Personalizar
Personalizar=(Fin)
