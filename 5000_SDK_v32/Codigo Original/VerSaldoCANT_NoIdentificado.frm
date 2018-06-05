[Forma]
Clave=VerSaldoCANT_NoIdentificado
Nombre=Anticipos Facturados
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAltura=120
PosicionInicialAncho=478
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=310
PosicionInicialArriba=279
BarraAcciones=S
AccionesDivision=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=101

[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerSaldoCANT_NoIdentificado
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.Saldo]
Carpeta=Lista
Clave=Saldo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20
Efectos=[Negritas]

[Lista.Cuenta]
Carpeta=Lista
Clave=Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.Moneda]
Carpeta=Lista
Clave=Moneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=0
NombreEnBoton=S
NombreDesplegar=&Copiar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
EnBarraAcciones=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cuenta
Cuenta=Moneda
Moneda=Saldo
Saldo=(Fin)
