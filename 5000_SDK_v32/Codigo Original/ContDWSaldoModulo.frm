[Forma]
Clave=ContDWSaldoModulo
Nombre=Auditor a Nivel Cuenta
Icono=7
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=490
PosicionInicialArriba=352
PosicionInicialAlturaCliente=460
PosicionInicialAncho=939
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Cuenta, Info.Descripcion)

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContDWSaldoModulo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Contacto<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
IconosNombre=ContDWSaldoModulo:ContDWSaldoModulo.Contacto
FiltroGeneral=ContDWSaldoModulo.Empresa=<T>{Empresa}<T> AND ContDWSaldoModulo.Cuenta=<T>{Info.Cuenta}<T>

[Lista.ContDWSaldoModulo.ContactoTipo]
Carpeta=Lista
Clave=ContDWSaldoModulo.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ContDWSaldoModulo.Neto]
Carpeta=Lista
Clave=ContDWSaldoModulo.Neto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Diferencia]
Carpeta=Lista
Clave=Diferencia
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=143
1=147

[Lista.ContDWSaldoModulo.SaldoModulo]
Carpeta=Lista
Clave=ContDWSaldoModulo.SaldoModulo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
NombreDesplegar=Personalizar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=Información del Contacto
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Caso ContDWSaldoModulo:ContDWSaldoModulo.ContactoTipo<BR>  Es <T>Cliente<T>   Entonces Asigna(Info.Cliente, ContDWSaldoModulo:ContDWSaldoModulo.Contacto) Forma(<T>CteInfo<T>)<BR>  Es <T>Proveedor<T> Entonces Asigna(Info.Proveedor, ContDWSaldoModulo:ContDWSaldoModulo.Contacto) Forma(<T>ProvInfo<T>)<BR>Fin
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ContDWSaldoModulo:ContDWSaldoModulo.Contacto)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Informacion
Informacion=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ContDWSaldoModulo.ContactoTipo
ContDWSaldoModulo.ContactoTipo=Cte.Nombre
Cte.Nombre=Prov.Nombre
Prov.Nombre=ContDWSaldoModulo.Neto
ContDWSaldoModulo.Neto=ContDWSaldoModulo.SaldoModulo
ContDWSaldoModulo.SaldoModulo=Diferencia
Diferencia=(Fin)
